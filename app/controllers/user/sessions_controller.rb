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
		if auth = request.env['omniauth.auth']
			user = User.new.from_omniauth(request.env['omniauth.auth'])
			if user.nil?
				@title = "Login"
				@user = User.new
				@user.errors.add(:name, " or email already exists")
				render "new"
			else
				sign_in user
				redirect_to root_path
			end
		else
			user = User.authenticate(params[:user][:name], params[:user][:password])
			if user.nil?
				@title = "Login"
				@user = User.new(:name => params[:user][:name])
				@user.errors.add(:password, " or username is incorrect")
				render "new"
			else
				sign_in user
				redirect_to root_path
			end
		end
	end
	
end
