# == Schema Information
#
# Table name: user_station_favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  station_id :integer
#  favorite   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserStationFavorite < ActiveRecord::Base
  attr_accessible :favorite, :station_id, :user_id

  after_save :change_counter

  before_create :init

  belongs_to :user
  belongs_to :station

  private

  	def change_counter
  		station = Station.find(self.station_id)
  		count = (self.favorite || self.favorite.nil?) ? station.favorites_count + 1 : station.favorites_count - 1
  		station.update_attributes(:favorites_count => count)
  		station.save(:validate => false)
  	end

  	def init
  		self.favorite = true
  	end

end
