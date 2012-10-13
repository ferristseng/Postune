# == Schema Information
#
# Table name: stations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  slug        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Station < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :slug

  # Validation
  validates :name,							:format => { :with => /^(\w| ){3,50}$/i }


  # Relationships
  belongs_to :user

  # Filters
  before_save :init

  # Override to_param
  def to_param
  	self.slug
  end

  private

  	def init
  		self.slug = generate_slug
  	end

  	def generate_slug
  		self.name.downcase.gsub(' ', '-')
  	end

end
