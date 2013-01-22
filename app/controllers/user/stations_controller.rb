class User::StationsController < ApplicationController

  include RedisHelper

  before_filter :default_access, :only => :new

  before_filter :find_station, :only => [ :show, :edit, :update, :destroy]

  def show
    @title = "Station"
    @song = Song.new
    if @station.blank?
      @station = params[:id]
      @url = "#{Settings['domain']}#{user_station_path params[:id]}"
      render 'user/stations/public_show'
    else
      @can_edit = @station.can_edit?(current_user)
      render 'user/stations/private_show'
    end
  end

  def public_new
    @title = "Home"
    @station = Station.new
    @recent = current_user.recently_played(3) if signed_in?
  end

  def new
    @title = "New Station"
    @station = Station.new
    build_collaborators(@station.collaborators.length)
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
    # Strip empty collaborator entries (no need to verify them)
    params[:station][:collaborators_attributes] = strip_empty_collaborators(params[:station][:collaborators_attributes])
    @station = Station.new(params[:station])
    if @station.save
      flash[:success] = "You have successfully created a station!"
      redirect_to user_station_path @station.permalink
    else
      @title = "New Station"
      build_collaborators(@station.collaborators.length)
      render 'new'
    end
  end

  def edit
    @title = "Edit Station"
    build_collaborators(@station.collaborators.length)
  end

  def update
    # Strip empty collaborator entries (no need to verify them)    
    params[:station][:collaborators_attributes] = strip_empty_collaborators(params[:station][:collaborators_attributes])
    if @station.update_attributes(params[:station])
      flash[:success] = "You have successfully edited your station!"
      redirect_to user_station_path @station.permalink
    else
      @title = "Edit Station"
      build_collaborators(@station.collaborators.length)
      render 'edit'
    end
  end

  def destroy

  end

  def online
    @title = "Online Stations"
    @online = Array.new
    $redis.smembers("online stations").each do |station|
      @online << Station.find_by_permalink(station)
    end
  end

  private

    def find_station
      @station = Station.find_by_permalink(params[:id])
    end

    def strip_empty_collaborators(collaborators)
      collaborators.each do |k, v|
        collaborators.delete(k) if v[:name].blank? && v[:title].blank?
        v[:current_user_id] = current_user.id
      end
      collaborators
    end

    def build_collaborators(len, times = 3)
      (times - len).times { @station.collaborators.build } if len < times
    end

end
