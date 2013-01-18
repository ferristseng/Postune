class User::ResetTokensController < ApplicationController

  def new
  	@title = "Reset Password"
  	if params[:token].present?
  		render 'user/reset_tokens/reset_form'
  	end
  	@token = ResetToken.new
  end

  def create
  	@token = ResetToken.new(params[:reset_token])
  	if @token.save
  		flash[:success] = "An email has been sent to you with more instructions to reset your password!"
  		redirect_to root_path
  	else
  		@title = "Reset Password"
  		render 'new'
  	end
  end

end
