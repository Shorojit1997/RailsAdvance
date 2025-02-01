require "grpc"
require_relative "../../lib/hello_services_pb"

class GreeterServer < Hello::Greeter::Service
  def say_hello(request, _unused_call)
    Hello::HelloReply.new(message: "Hello Sagor How are you, #{request.name}!")
  end
end

def main
  server = GRPC::RpcServer.new
  server.add_http2_port("0.0.0.0:50051", :this_port_is_insecure)
  server.handle(GreeterServer)
  puts "gRPC server running on port 50051..."
  server.run_till_terminated
end

main if __FILE__ == $0
