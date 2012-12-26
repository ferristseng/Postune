Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :facebook, Settings['api_keys']['facebook']['client_key'], Settings['api_keys']['facebook']['client_secret']
end