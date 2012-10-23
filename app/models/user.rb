# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password        :string(255)
#  activation_code :string(255)
#  group_id        :integer
#  is_active       :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  salt            :string(255)
#  last_sign_in    :datetime
#

require 'digest'

class User < ActiveRecord::Base
	attr_accessor :unencrypted_password, :updating_password
	attr_accessible :name, :email, :group_id, :is_active, :unencrypted_password, :unencrypted_password_confirmation, :updating_password
	
	
	# Validation Settings
	validates :name,  											:uniqueness => { :case_sensitive => false },
																					:format => { :with => /^\w{3,50}$/i }
	validates :email,												:format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
																					:uniqueness => { :case_sensitive => false }
	validates :unencrypted_password,				:confirmation => true,
																					:length => { :within => 6..50 },
																					:if => :should_validate?

	belongs_to :group
	
	# Filters
	before_save :init

	# Override to param
	def to_param
		self.name.downcase
	end

	def self.authenticate(username, submitted_password)
		user = User.find_by_name(username.downcase)
		return nil if user.nil?
		return user if user.password == User.make_salt("#{user.salt}#{submitted_password}") && user.is_active
	end

	# Salt a given string	
	def self.make_salt(string)
		Digest::SHA2.hexdigest(string)
	end
	
	private 

		# Initialize all the User values	
		def init
			self.is_active 						||= 0
			self.group_id 						||= 1
			self.salt 								||= User.make_salt("#{Time.now.utc}**")
			self.activation_code 			||= generate_activation_code
			self.password 						= (should_validate?) ? generate_encrypted_password : self.password
			self.email 								= self.email.downcase
			self.name 								= self.name.downcase
		end	
		
		def generate_activation_code
			User.make_salt(self.email)
		end
		
		def generate_encrypted_password
			User.make_salt("#{self.salt}#{unencrypted_password}")
		end

		def should_validate?
			updating_password || new_record?
		end	

end
