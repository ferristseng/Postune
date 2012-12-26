module SessionsHelper
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id]
		user.update_attributes(:last_sign_in => DateTime.now)
		user.save! :validate => false
		self.current_user = user
	end
	
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= User.find_by_id(remember_token)
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def admin?
		current_user.group.permission == 9
	end

	def default_access
		redirect_to user_register_path, :notice => "Please sign in to continue" unless signed_in?
	end
	
	def admin_access
		redirect_to root_path unless admin?
	end

	def can_edit_station?(station)
		station.user == current_user
	end

	private
	
		def remember_token
			cookies.signed[:remember_token] || [nil]
		end
end