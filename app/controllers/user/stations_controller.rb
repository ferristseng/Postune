class User::StationsController < ApplicationController

  before_filter :default_access, :only => :new

  def show
    @title = "Station"
    @song = Song.new
    @station = Station.find_by_permalink(params[:id])
    if @station.blank?
      @station = params[:id]
      @url = "#{Settings['domain']}#{user_station_path params[:id]}"
      render 'user/stations/public_show'
    else
      @can_edit = current_user.can_edit?(@station)
      render 'user/stations/private_show'
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
    @collaborator_num = 3
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
    #@station = Station.new(:name => params[:station][:name], :user_id => params[:station][:user_id])
    @station = Station.new(params[:station])
    if @station.save
      flash[:success] = "You have successfully created a station!"
      redirect_to user_station_path @station.permalink
    else
      @title = "New Station"
      @collaborator_num = params[:station][:collaborators_attributes].length
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

end
