class User::StationsController < ApplicationController

  def show
    @title = "Station"
    @song = Song.new
    @station = params[:id]
  end

  def new
    @title = "Home"
  end

  # to do
  # Add validation
  def create
    id = params[:name].to_url
    redirect_to user_station_path(id)
  end

end
