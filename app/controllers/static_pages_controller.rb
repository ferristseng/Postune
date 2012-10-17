class StaticPagesController < ApplicationController
  def css
  	@title = "CSS Test Page"
  end

  def error_404
  	@title = "404"
  end

  def error_500
  	@title = "500"
  end
end
