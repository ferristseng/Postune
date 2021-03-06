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
	attr_accessible :name, :email, :group_id, :is_active, :unencrypted_password, :unencrypted_password_confirmation, :updating_password, :last_sign_in
	
	
	# Validation Settings
	validates :name,  											:uniqueness => { :case_sensitive => false },
																					:format => { :with => /^[a-zA-Z0-9\.]{3,50}$/i }
	validates :email,												:format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
																					:uniqueness => { :case_sensitive => false }
	validates :unencrypted_password,				:confirmation => true,
																					:length => { :within => 6..50 },
																					:if => :should_validate?

	belongs_to :group

	has_many :stations
	has_many :songs
	has_many :authorizations
	
	has_many :user_station_favorites
  has_many :favorites, :through => :user_station_favorites, :source => :station, :conditions => 'favorite = true'

	# Before Save
	before_save :init

	# Override to param
	def to_param
		self.name.downcase
	end

	def recently_played(limit = 4)
		self.songs.order("created_at DESC").limit(limit)
	end

	def self.authenticate(username, submitted_password)
		user = User.find_by_name(username.downcase)
		return nil if user.nil?
		return user if user.password == User.make_salt("#{user.salt}#{submitted_password}") && user.is_active
	end

	# For Omniauth
	def from_omniauth(auth)
		user = User.find_by_email(auth.info.email)
		user.authorizations.build(:uid => auth.uid, :provider => auth.provider) if !user.authorizations.find_by_provider(auth.provider).nil?
		user.save!
		return user if !user.nil?
		self.name = "#{auth.info.nickname}_#{User.provider_to_abbr(auth.provider)}"
		self.email = auth.info.email
		self.password = User.generate_random_password
		self.authorizations.build(:uid => auth.uid, :provider => auth.provider)
		return self if self.save
		return nil
	end

	def self.provider_to_abbr(provider)
		case
		when "facebook"
			"fb"
		when "twitter"
			"tw"
		when "tumblr"
			"tb"
		end
	end

	# For Favoriting / Favorites
	def favorite(station)
		if (favorite = UserStationFavorite.find(:first, :conditions => ['user_id = ? AND station_id = ?', self.id, station.id])).nil?
			self.user_station_favorites << UserStationFavorite.create(:user_id => self.id, :station_id => station.id)
		else
			favorite.update_attributes!(:favorite => true)
		end
	end

	def unfavorite(station)
		self.user_station_favorites.find_by_station_id(station.id).update_attributes!(:favorite => false)
	end

	def favorited?(station)
		!self.user_station_favorites.find(:first, :conditions => ['station_id = ? AND user_id = ? AND favorite = ?', station.id, self.id, true]).nil?
	end

	# Salt a given string	
	def self.make_salt(string)
		Digest::SHA2.hexdigest(string)
	end

	def self.generate_random_password
		SecureRandom.hex(20)
	end
	
	private 

		# Initialize all the User values	
		def init
			self.is_active 						||= 1
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
