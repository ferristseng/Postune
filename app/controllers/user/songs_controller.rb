require 'open-uri'

class User::SongsController < ApplicationController

  include RedisHelper

  # This will create a new song on the station and publish it to redis
  def create
    params[:song][:user_id] = current_user.id
    @song = Song.new(params[:song])
    if @song.save
      redis_auth
      user = { :name => current_user.name, :permalink => user_user_path(current_user), :color => current_user.color }
      $redis.publish "new song", ActiveSupport::JSON.encode({ :station => params[:station_id], :user => user, :song => @song })
      render :js => "ajaxCallback('#{params[:div]}', 1)"
    else
      render :js => "ajaxCallback('#{params[:div]}', -1)"
    end
  end

  def search
    @songs = [];
    if !params[:query].blank?
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
    end
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

      @s_page = 1 if @s_page < 1
      @e_page = @m_page if @e_page > @m_page
    end

end
