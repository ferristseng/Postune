class User::SessionsController < ApplicationController

  def new
		@title = "Login"
		if signed_in?
			redirect_to root_path
		else
			@user = User.new
		end
	end
	
	def destroy
		sign_out
		redirect_to user_login_path
	end
	
	def create
		user = User.authenticate(params[:user][:name], params[:user][:password])
		if user.nil?
			@title = "Login"
			@user = User.new(:name => params[:user][:name])
			flash[:error] = "Username or password is incorrect"
			render "new"
		else
			sign_in user
			redirect_to root_path
		end
	end
	
end
