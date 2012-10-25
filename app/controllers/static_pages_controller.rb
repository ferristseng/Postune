class StaticPagesController < ApplicationController
	def splash
		@title = "Welcome"
		if signed_in?
			redirect_to home_path
		end
	end

	def rules
		@title = "Rules"
	end

	def contact
		@title = "Contact"
	end

	def faq
		@title = "FAQ"
	end

  def error_404
  	@title = "404"
  end

  def error_500
  	@title = "500"
  end
end
