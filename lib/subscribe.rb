require "uri"
require "net/http"
require "net/https"
require "dotenv"
require "redis"
require 'json'

Dotenv.load

def send_ir_signal( payload  )
	url = ENV["IRKIT_HOST"] + "/messages"
	uri = URI.parse url
	https = Net::HTTP.new(uri.host, uri.port)
	https.use_ssl = false 
	req = Net::HTTP::Post.new(uri.request_uri)
	req["Content-Type"] = "text/plain"
	req["X-Requested-With"] = "curl"
	req.body = payload
	res = https.request(req)
end 


$redis = Redis.new(url: ENV["REDIS_URL"])

$redis.subscribe('ir_request') do |on|
	on.message do |channel, msg|
		send_ir_signal msg
	end
end



