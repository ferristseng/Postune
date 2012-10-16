require 'open-uri'

class User::SongsController < ApplicationController

  def index
    render :layout => false
  end

  def create
    # set other params
    params[:song][:user_id] = current_user.id
    params[:song][:station_id] = current_user.station.id
    @song = Song.new(params[:song])
    if @song.save
      render :js => "alert('GOOD!')"
    else

    end
    
  end

  def update
  end

  def search
  	base_url = "http://ex.fm/api/v3/song/search/"
  	search_url = "#{base_url}#{URI.encode(params[:query])}?results=5&start=#{(params[:start].to_i - 1) * 5}"
    puts search_url
  	raw_content  = open(search_url) {|f| f.read }
  	json = ActiveSupport::JSON.decode raw_content
  	@songs = json['songs']
    # pagination
  	@pages = json['total'] / 5
  	@current = json['start'] / 5
    @page = (params[:start].to_i > 1) ? @current - 1 : @current
    @max_page = (@pages > 5) ? @current + 4 : @current
    # query and song params
    @query = params[:query]
    @song = Song.new
  end

  def destroy
  end
end
