require "uri"
require "net/http"
require "net/https"
require "dotenv"
require "redis"
require 'json'

Dotenv.load

$redis = Redis.new(url: ENV["REDIS_URL"])

$redis.subscribe('channel_test') do |on|
	on.message do |channel, msg|
		p msg
	end
end

