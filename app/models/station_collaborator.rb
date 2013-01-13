class StationCollaborator < ActiveRecord::Base
  attr_accessible :station_id, :title, :user_id, :name

  belongs_to :user
  belongs_to :station

  before_save :init

  accepts_nested_attributes_for :station

  private

  	def init
  		self.title ||= "Collaborator"
  	end

end
