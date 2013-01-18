class ResetToken < ActiveRecord::Base
	attr_accessor :email
  attr_accessible :expires, :reset_token, :user_id, :email

  validates :email, :presence => true
  validate :user_exists

  before_create :init

  # [True] if expired
  def expired?
  	!self.expires.future?
  end

  private

  	def user_exists
  		begin
  			self.user_id = User.find_by_email(self.email.downcase).id
  		rescue
  			self.errors.add(:email, "User with that email does not exist")
  		end
  	end

		def generate_token
			begin
				token = SecureRandom.urlsafe_base64
			end while ResetToken.where(:reset_token => token).exists?
			token
		end

		def week_from_now
			Time.now + (7 * 60 * 60 * 24)
		end

		def init
			self.reset_token = generate_token
			self.expires = week_from_now.to_datetime
		end
end
