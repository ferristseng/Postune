class User::StationsController < ApplicationController

  before_filter :default_access, :only => :private_new

  def show
    @title = "Station"
    @song = Song.new
    @station = params[:id]
  end

  def public_new
    @title = "Home"
  end

  def new
    @title = "New Station"
  end

  def public_create
    id = params[:name].to_url
    if id.empty?
      @title = "Home"
      flash[:error] = "Please enter something"
      render 'new'
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
