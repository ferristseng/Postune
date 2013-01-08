OmniAuth.config.full_host = lambda do |env|
    scheme         = env['rack.url_scheme']
    local_host     = env['HTTP_HOST']
    forwarded_host = env['HTTP_X_FORWARDED_HOST']
    forwarded_host.blank? ? "#{scheme}://#{local_host}" : "#{scheme}://#{forwarded_host}"
end

Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :facebook, Settings['facebook']['client_key'], Settings['facebook']['client_secret']
end