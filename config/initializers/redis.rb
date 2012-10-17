$redis = Redis.new :host => Settings['redis']['host'], :port => Settings['redis']['port']

if !Settings['redis']['auth'].empty?
	$redis.auth Settings['redis']['auth']
end