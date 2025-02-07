require 'grpc'
$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'todo_services_pb'
require 'todo_server'

server = GRPC::RpcServer.new
server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
server.handle(TodoServer)
puts "gRPC server running on 0.0.0.0:50051"
server.run_till_terminated