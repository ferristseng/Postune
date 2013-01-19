class User::FavoritesController < ApplicationController

	before_filter :default_access

	def create
		station = Station.find_by_permalink(params[:station_id])
		favorited = false
		# Unfavorite
		if current_user.favorited?(station)
			current_user.unfavorite(station)
		# Favorite
		else
			current_user.favorite(station)
			favorited = true
		end
		render :js => "$('.favorite-link').attr('class', 'favorite-link label #{favorited ? 'red' : 'yellow'}').html('#{favorited ? 'Unfavorite' : 'Favorite'}')"
	end

end
