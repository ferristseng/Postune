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
