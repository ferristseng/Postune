class User::UsersController < ApplicationController
  
	before_filter :default_access, :only => [ :edit, :show ]

  def new
  	if signed_in?
  		redirect_to root_path
  	else
	  	@title = 'Register'
	  	@user = User.new
	  end
  end

  def create
  	@user = User.new params[:user]
  	if @user.save
  		redirect_to root_path
  	else
  		@title = 'Register'
  		render 'new'
  	end
  end

  def edit

  end

  def show
    @user = User.find_by_name params[:id]
    @title = @user.name
  end

end
