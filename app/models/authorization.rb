class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id

  belongs_to :user

  validates :provider, 	:presence => true
  validates :uid,				:presence => true
end
