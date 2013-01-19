class User::ResetTokensController < ApplicationController

  def new
  	@title = "Reset Password"
  	if params[:token].present?
      if !(@token = ResetToken.find_unexpired(params[:token])).nil?
        @user = @token.user
        render 'user/reset_tokens/reset_form'
      else
        flash[:error] = "The reset token you provided has expired!"
        redirect_to root_path
      end
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

  def reset
    @user = User.find_by_name(params[:user_id])
    params[:user][:updating_password] = true
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "You have successfully changed your password!"
      redirect_to root_path
    else
      @title = "Reset Password"
      render 'user/reset_tokens/reset_form'
    end
  end

end
