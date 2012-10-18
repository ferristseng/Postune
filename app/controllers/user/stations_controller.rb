class User::StationsController < ApplicationController

  before_filter :default_access, :except => [ :show ]
  before_filter :find_user
  before_filter :find_station, :except => [ :new ]

  def show
    @title = @station.name
    @song = Song.new
    @songs = @station.songs.order("created_at DESC").limit(3)
  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def find_user
      @user = User.find_by_name(params[:user_id])
    end

    def find_station
      @station = Station.find(:first, :conditions => ["slug = ? AND user_id = ?", params[:slug], @user.id])
    end
end
