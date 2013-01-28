module StationsHelper

	def link_to_favorite(station, label = { :favorite => "Favorite", :unfavorite => "Unfavorite" })
		if signed_in?
			favorited = current_user.favorited?(station)
			raw link_to(
						favorited ? label[:unfavorite] : label[:favorite], 
						user_station_favorite_path(station), 
						:method => :post,
						:remote => true,
						:class => "favorite-link label #{favorited ? 'red' : 'yellow'}"
					)
		end
	end

	def station_label(station)
		priv = station.private?
		raw content_tag(:span, priv ? "Private" : "Public", { :class => "label #{priv ? 'red' : 'green'}"})
	end

end
