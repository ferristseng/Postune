class User::StationsController < ApplicationController

  include RedisHelper

  before_filter :default_access, :only => :new

  before_filter :find_station, :only => [ :show, :edit, :update, :destroy]

  before_filter :can_edit_or_redirect, :only => [ :edit, :update ]
  before_filter :private_or_redirect, :only => [ :edit ]

  def show
    @title = "Station"
    @song = Song.new
    if @station.private?
      @can_edit = @station.can_edit?(current_user)
      render 'user/stations/private_show'
    else
      render 'user/stations/public_show'
    end
  end

  def public_new
    @title = "Home"
    @station = Station.new
    @recent = current_user.recently_played if signed_in?
  end

  def new
    @title = "New Station"
    @station = Station.new
    build_collaborators(@station.collaborators.length)
  end

  def public_create
    if params[:station][:name].empty?
      public_new
      @station.errors.add(:name, "is invalid")
      render 'public_new'
    else
      @station = Station.where('lower(name) = ?', params[:station][:name].downcase).first_or_create(:name => params[:station][:name])
      redirect_to user_station_path @station
    end
  end

  # 
  # Create [POST]
  # Objective is to create a PRIVATE station
  # If a public exists with the same NAME, then just transfer ownership to the user trying to make the new station
  # Otherwise, just create the private station
  def create
    # Strip empty collaborator entries (no need to verify them)
    params[:station][:collaborators_attributes] = strip_empty_collaborators(params[:station][:collaborators_attributes])
    @station = Station.where('lower(name) = ? AND user_id is NULL', params[:station][:name].downcase).first_or_initialize(params[:station])
    if @station.user_id == nil
      @station.update_attributes(params[:station])
    end
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
    if @station.is_owner?
      @station.destroy
      flash[:success] = "You have successfully deleted #{@station.name}!"
    else
      flash[:error] = "You can not delete this station!"
    end
    redirect_to root_path
  end

  def index
    @title = "Online Stations"
    @online = Station.online
    @popular = Station.order("favorites_count DESC").limit(10)
  end

  def shuffle
    @online = Station.online
    if @online.empty?
      redirect_to root_path
      flash[:notice] = "Sorry, there are no stations online at this time!"
    else
      redirect_to user_station_path(@online.sample)
    end
  end

  private

    def find_station
      @station = Station.find_by_permalink(params[:id])
    end

    def find_online_stations

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

    def private_or_redirect
      redirect_to root_path and flash[:error] = "You can not access that page!" unless @station.private?
    end

    def can_edit_or_redirect
      redirect_to root_path and flash[:error] = "You can not access that page!" unless @station.can_edit?(current_user)
    end
end
