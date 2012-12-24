class User::StationsController < ApplicationController

  before_filter :default_access, :only => :new

  def show
    @title = "Station"
    @song = Song.new
    @station = params[:id]
  end

  def public_new
    @title = "Home"
    @station = Station.new
    @recent = current_user.recently_played if signed_in?
  end

  def new
    @title = "New Station"
    @station = Station.new
  end

  def public_create
    id = params[:station][:name].to_url
    if id.empty?
      public_new
      @station.errors.add(:name, "is invalid")
      render 'public_new'
    else
      redirect_to user_station_path id
    end
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
