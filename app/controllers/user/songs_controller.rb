require 'open-uri'

class User::SongsController < ApplicationController

  include RedisHelper

  # 
  # This will create a new song on the station and publish it to redis
  # ==
  # Token will be a special token to identify the user and only allow him to play music
  # ==
  def create
    # set other params
    params[:song][:user_id] = current_user.id
    @song = Song.new(params[:song])
    if @song.save
      redis_auth
      $redis.publish "new song" ,ActiveSupport::JSON.encode({ :token => "", :station => params[:station_id], :user => current_user.name, :song => @song })
      render :js => "console.log('guter')"
    else
      render :js => "console.log('error')"
    end
  end

  def search
    @station = params[:station_id]
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

end
