class User::UsersController < ApplicationController
  
	before_filter :default_access, :only => [ :edit, :show ]
  before_filter :find_user, :only => [ :show, :edit, :edit_password, :update_password ]
  before_filter :find_user_by_id, :only => [ :update ]

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
  	@user = User.new(params[:user])
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
    @title = 'Edit Account Info'
  end

  def update
    @title = 'Edit Account Info'
    @init_user = @user
    # Delete the password key, can't update it directly!
    pass = params[:user].delete(:password)
    # Strip key / val pairs that match the user's account already
    params[:user].each do |k, v| 
      if (v == @user[k] || v.blank?) 
        params[:user].delete(k) 
      else
        @user[k] = v
      end
    end
    if !User.authenticate(@init_user.name, pass).nil?
      if @user.save
        flash[:success] = "Your account information has been edited!"
        redirect_to user_user_path(@user)
      else
        render 'edit'
      end
    else
      @user.errors.add(:password, "could not be authenticated")
      render 'edit'
    end
  end

  def edit_password
    @title = 'Edit Password'
  end

  def update_password
    @title = 'Edit Password'
    # Delete the password key, can't update it directly!
    pass = params[:user].delete(:password)
    # Make sure you validate!
    params[:user][:updating_password] = true
    if !User.authenticate(@user.name, pass).nil?
      @user.update_attributes(params[:user])
      if @user.save
        flash[:success] = "Your password has been changed!"
        # Send an email notification?
        redirect_to user_user_path(@user)
      else
        render 'edit_password'
      end
    else
      @user.errors.add(:password, "could not be authenticated")
      render 'edit_password'
    end
  end

  def show
    @title = @user.name
  end

  private

    def find_user
      @user = User.find_by_name(params[:id] || params[:user_id])
    end

    def find_user_by_id
      @user = User.find(params[:id] || params[:user_id])
    end

end
