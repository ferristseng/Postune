require 'stringex'

class Station < ActiveRecord::Base
  attr_accessible :name, :permalink, :user_id, :collaborators

  belongs_to :user

  has_many :collaborators, :class_name => StationCollaborator, :foreign_key => :station_id
  has_many :users, :through => :station_collaborators

  # Setup permalink as a url field
  acts_as_url :name, :url_attribute => :permalink

  validates :name, 				:presence => true

  def position(user)
  	if is_owner?(user)
  		return "Owner"
  	elsif is_collaborator?(user)
  		return StationCollaborator.find(:first, :conditions => ['user_id = ? AND station_id = ?', self.user_id, self.station_id]).title
  	else
  		return ""
  	end
  end

  def is_owner?(user)
  	user.id == self.user_id
  end

  def is_collaborator?(user)
  	self.collaborators.include? user
  end

end
