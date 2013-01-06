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
      $redis.publish "new song", ActiveSupport::JSON.encode({ :token => "", :station => params[:station_id], :user => current_user.name, :song => @song })
      render :js => "ajaxCallback('#{params[:div]}', 1)"
    else
      render :js => "ajaxCallback('#{params[:div]}', -1)"
    end
  end

  def search
    @station = params[:station_id]
    max_results = Settings['station']['max_results'].to_i
  	base_url = "http://ex.fm/api/v3/song/search/"
  	search_url = "#{base_url}#{URI.encode(params[:query])}?results=#{max_results + 10}&start=#{(params[:start].to_i - 1) * max_results}"
  	raw_content  = open(search_url) {|f| f.read }
  	json = ActiveSupport::JSON.decode raw_content
  	@songs = json['songs'][0..15]
    paginate_results(json['total'], json['start'], max_results)
    # query and song params
    @query = params[:query]
    @song = Song.new
  end

  private

    def paginate_results(total_pages, start_page, max_results)
      x = 5

      offset = (x / 2).floor
      center = offset + 1

      @m_page     = (total_pages / max_results).floor + 1
      @c_page     = (start_page / max_results).floor + 1
      @s_page     = 0
      @e_page     = 0

      # Set the end page
      if @c_page + offset > @m_page
        @s_page = @m_page - x + 1
        @e_page = @m_page 
      else
        @e_page = @c_page + offset
      end

      # Set the start page
      if @c_page > offset && @s_page == 0
        @s_page = @c_page - offset
      elsif @s_page == 0
        @s_page = @c_page - (@c_page - 1)
        @e_page = @c_page + (x - @c_page)
      end
    end

end
