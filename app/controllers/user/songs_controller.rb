require 'open-uri'

class User::SongsController < ApplicationController

  before_filter :find_user, :only => [ :index ]
  before_filter :find_station, :only => [ :index ]

  # 
  # ONLY ACCESSIBLE BY JAVASCRIPT
  # Will give the list of songs that have been played for a given station
  # ==
  def index
    @songs = @station.songs.paginate(:page => params[:page], :per_page => Settings['station']['max_results']).order("created_at DESC")

    respond_to do |format|
      format.js { render :partial => 'user/songs/partials/history' ,:layout => false }
    end
  end

  # 
  # This will create a new song on the station and publish it to redis
  # ==
  # Token will be a special token to identify the user and only allow him to play music
  # ==
  def create
    # set other params
    params[:song][:user_id] = current_user.id
    params[:song][:station_id] = current_user.station.id
    @song = Song.new(params[:song])
    if @song.save
      $redis.publish "new song" ,ActiveSupport::JSON.encode({ :token => "", :song => @song })
      render :js => "console.log('guter')"
    else
      render :js => "console.log('error')"
    end
  end

  def search
    max_results = Settings['station']['max_results'].to_i
  	base_url = "http://ex.fm/api/v3/song/search/"
  	search_url = "#{base_url}#{URI.encode(params[:query])}?results=#{max_results}&start=#{(params[:start].to_i - 1) * max_results}"
  	raw_content  = open(search_url) {|f| f.read }
  	json = ActiveSupport::JSON.decode raw_content
  	@songs = json['songs']
    # pagination
  	@pages = json['total'] / max_results
  	@current = json['start'] / max_results
    @page = (params[:start].to_i > 1) ? @current - 1 : @current
    @max_page = (@pages > max_results) ? @current + 4 : @current
    # query and song params
    @query = params[:query]
    @song = Song.new
  end

  # 
  # This will create a new song on the station with the given changes and publish it to redis
  # ==
  # Token
  # ==
  def update
    # Find the song
    @exist = Song.find(params[:id])
    # Assign some values
    params[:song][:user_id] = current_user.id
    params[:song][:station_id] = current_user.station.id
    params[:song][:path] = @exist.path
    params[:song][:artwork] = @exist.artwork
    # Make a new Song object
    @song = Song.new(params[:song])
    if @song.save!
      $redis.publish "new song" ,ActiveSupport::JSON.encode({ :token => "", :song => @song })
      render :js => "console.log('guter')"
    else
      render :js => "console.log('error')"
    end 
  end

  private

    def find_user
      @user = User.find_by_name(params[:user_id])
    end

    def find_station
      @station = Station.find(:first, :conditions => ["slug = ? AND user_id = ?", params[:slug], @user.id])
    end

end
