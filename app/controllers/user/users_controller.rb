class User::UsersController < ApplicationController
  
	before_filter :default_access, :only => [ :edit, :show ]

  def new
  	if signed_in?
  		redirect_to root_path
  	else
	  	@title = 'Register'
	  	@user = User.new
      @user_alt = User.new
	  end
  end

  def create
  	@user = User.new params[:user]
  	if @user.save
  		sign_in @user
      redirect_to root_path
  	else
  		@title = 'Register'
      @user_alt = User.new
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
