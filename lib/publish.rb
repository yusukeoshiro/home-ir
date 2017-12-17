require "uri"
require "net/http"
require "net/https"
require "dotenv"
require "redis"
Dotenv.load

$redis = Redis.new(url: ENV["REDIS_URL"])

data = {"user" => "test"}
loop do
	$redis.publish "channel_test", "value"
end


$redis.set("test","helloworld")
$redis.expire("test",180)
$redis.close
