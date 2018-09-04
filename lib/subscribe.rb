require "uri"
require "net/http"
require "net/https"
require "dotenv"
require "redis"
require 'json'
require "pp"
Dotenv.load

def send_ir_signal( ip_address, payload )
	url = "http://" + ip_address + "/messages"
	uri = URI.parse url
	https = Net::HTTP.new(uri.host, uri.port)
	https.use_ssl = false 
	https.open_timeout = 2
	req = Net::HTTP::Post.new(uri.request_uri)
	req["Content-Type"] = "text/plain"
	req["X-Requested-With"] = "curl"
	req.body = payload
	res = https.request(req)
end 


$redis = Redis.new(url: ENV["REDIS_URL"])

$redis.subscribe('ir_request') do |on|
	on.message do |channel, msg|
		begin
                	p "detected new signal request..."
                	p msg
               		payload = JSON.parse msg
                	pp payload
                	send_ir_signal( payload["emitter_ip_address"], payload["signal_body"] )
		rescue
			p "failed"
		end
	end
end



