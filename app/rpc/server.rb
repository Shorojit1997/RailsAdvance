# app/rpc/server.rb
require "grpc"
require_relative "services/hello_world_services_pb"

class GreeterServer < HelloWorld::Greeter::Service
  def say_hello(hello_req, _unused_call)
    HelloWorld::HelloReply.new(message: "Hello sagor, #{hello_req.name}!")
  end
end

server = GRPC::RpcServer.new
server.add_http2_port("0.0.0.0:50051", :this_port_is_insecure)
server.handle(GreeterServer)

puts "gRPC server running on 0.0.0.0:50051..."
server.run_till_terminated
