module RedisHelper

	def redis_auth
		if !Settings['redis']['auth'].empty?
			$redis.auth Settings['redis']['auth']
		end
	end

end