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

  before_create :init

  belongs_to :user
  belongs_to :station

  private

  	def init
  		self.favorite = true
  	end

end
