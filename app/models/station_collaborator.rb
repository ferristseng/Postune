# == Schema Information
#
# Table name: station_collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  station_id :integer
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StationCollaborator < ActiveRecord::Base
	attr_accessor :name, :current_user_id
  attr_accessible :station_id, :title, :user_id, :name, :current_user_id

  belongs_to :user
  belongs_to :station

  validate 	:user_exists?
  validate 	:user_owner?

  before_validation :init

  alias_method :original_name, :name

  def name
  	self.original_name.present? ? self.original_name : (self.user_id.blank? ? "" : User.find(self.user_id).name)
  end

  private

  	# This part works, but clean it up a bit to make
  	# it a bit nicer / follow convention

  	def user_exists?
  		self.errors.add(:name, "does not exist!") unless self.user_id.present?
  	end

  	def user_owner?
  		if self.user_id.present?
  			self.errors.add(:name, "owns the station!") unless User.find(self.user_id).id != self.current_user_id
  		end
  	end

  	def init
  		u = User.find_by_name(self.name.downcase)
  		self.title ||= "Collaborator"
  		self.user_id = !u.nil? ? u.id : nil
  	end

end
