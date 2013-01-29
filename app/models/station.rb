# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'stringex'

class Station < ActiveRecord::Base

  include RedisHelper

  attr_accessible :name, :permalink, :user_id, :collaborators_attributes, :collaborators, :favorites_count

  belongs_to :user

  has_many :collaborators, :class_name => StationCollaborator, :foreign_key => :station_id
  has_many :favorites, :class_name => UserStationFavorite, :foreign_key => :station_id, :conditions => ['favorite = ?', true]

  accepts_nested_attributes_for :collaborators, :allow_destroy => true

  # Setup permalink as a url field
  acts_as_url :name, :url_attribute => :permalink, :sync_url => true

  validates :name,  :presence => true,
                    :uniqueness => { :case_sensitive => false }

  def self.online(num = Settings['station']['online_num'])
    $redis.smembers("online stations").shuffle.take(num).collect { |station| Station.find_by_permalink(station) }
  end

  # Naming
  def to_param
    self.permalink
  end

  def short_name
    self.name.truncate(20, :omission => "...")
  end

  def position(user)
  	if is_owner?(user)
  		return "Owner"
  	elsif is_collaborator?(user)
  		return StationCollaborator.find(:first, :conditions => ['user_id = ? AND station_id = ?', user.id, self.id]).title
  	else
  		return "Collaborator"
  	end
  end

  # Permissions
  def can_edit?(user)
    is_owner?(user) || is_collaborator?(user)
  end

  def is_owner?(user)
  	user.nil? ? false : user.id == self.user_id
  end

  def is_collaborator?(user)
    user.nil? ? false : self.collaborators.find_by_user_id(user.id).present?
  end

  def private?
    self.user_id.present?
  end

end
