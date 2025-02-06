require 'grpc'
require_relative '../../lib/hello_services_pb'

def main
  stub = Hello::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
  response = stub.say_hello(Hello::HelloRequest.new(name: 'Rails User'))
  puts "Received: #{response.message}"
end

main if __FILE__ == $0
