class ResetToken < ActiveRecord::Base
	attr_accessor :email
  attr_accessible :expires, :reset_token, :user_id, :email

  validates :email, :presence => true
  validate :user_exists

  belongs_to :user

  before_create :init
  after_create :send_email

  def to_param
    self.reset_token
  end

  # [True] if expired
  def expired?
  	!self.expires.future?
  end

  def self.find_unexpired(token)
    ResetToken.find(:last, :conditions => ['reset_token = ? AND expires > ?', token, DateTime.now])
  end

  def invalidate
    self.update_attributes(:expires => DateTime.now)
    self.save(:validate => false)
  end

  def invalidate_all
    ResetToken.find(:all, :conditions => ['user_id = ? AND expires > ?', self.user_id, DateTime.now]).each { |r| r.invalidate }
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

    def send_email
      User::UserMailer.reset_password(self).deliver
    end

		def init
			self.reset_token = generate_token
			self.expires = week_from_now.to_datetime
		end
end
