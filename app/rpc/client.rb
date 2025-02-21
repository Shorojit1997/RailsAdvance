# app/rpc/client.rb
require "grpc"
require_relative "services/hello_world_services_pb"

stub = HelloWorld::Greeter::Stub.new("localhost:50051", :this_channel_is_insecure)
request = HelloWorld::HelloRequest.new(name: "World")
response = stub.say_hello(request)

puts "Response from server: #{response.message}"
