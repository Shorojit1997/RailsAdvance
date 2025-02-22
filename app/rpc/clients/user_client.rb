require "grpc"
require_relative "../generated/user_service_services_pb"

stub = Rpc::UserService::Stub.new("localhost:50051", :this_channel_is_insecure)
request = Rpc::UpdateUserRequest.new(id: 3, name: "John Doe", age: 30)

begin
  response = stub.update_user(request)
  puts "Response: #{response.message}"
rescue GRPC::BadStatus => e
  puts "Error: #{e.message}"
end


# create_request = Rpc::CreateUserRequest.new(name: "Jane Doe", age: 28)

# begin
#   create_response = stub.create_user(create_request)
#   if create_response.success
#     puts "User created successfully! ID: #{create_response.id}"
#   else
#     puts "Failed to create user: #{create_response.message}"
#   end
# rescue GRPC::BadStatus => e
#   puts "Error: #{e.message}"
# end
