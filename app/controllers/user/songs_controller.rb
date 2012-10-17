require 'open-uri'

class User::SongsController < ApplicationController

  def index
    @songs = Song.paginate(:page => params[:page], :per_page => Settings['station']['max_results']).order("created_at DESC")

    respond_to do |format|
      format.js { render :partial => 'user/songs/partials/history' ,:layout => false }
    end
  end

  def show

  end

  def create
    # set other params
    params[:song][:user_id] = current_user.id
    params[:song][:station_id] = current_user.station.id
    @song = Song.new(params[:song])
    if @song.save
      $redis.publish "new songs" ,ActiveSupport::JSON.encode({ :token => "", :song => @song })
      render :js => "console.log('guter')"
    else
      render :js => "console.log('error')"
    end
    
  end

  def update
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

  def destroy

  end

  private

end
