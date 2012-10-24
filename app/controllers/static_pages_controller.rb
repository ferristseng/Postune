class StaticPagesController < ApplicationController
	def splash
		@title = "Welcome"
		if signed_in?
			redirect_to home_path
		end
	end

  def error_404
  	@title = "404"
  end

  def error_500
  	@title = "500"
  end
end
