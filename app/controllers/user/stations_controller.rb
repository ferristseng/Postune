class User::StationsController < ApplicationController

  before_filter :default_access, :except => [ :show ]
  before_filter :find_user
  before_filter :find_station, :except => [ :new ]

  def show
  end

  def new
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
      @station = @user.stations.find_by_slug(params[:slug])
    end
end
