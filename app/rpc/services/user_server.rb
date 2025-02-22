require "grpc"
require_relative "../generated/user_service_services_pb"

class UserServer < Rpc::UserService::Service  # Use the `Rpc` namespace
  def update_user(request, _unused_call)
    user = User.find(request.id)
    user.update!(name: request.name, age: request.age)

    Rpc::UpdateUserResponse.new(success: true, message: "User updated successfully")
  rescue => e
    Rpc::UpdateUserResponse.new(success: false, message: "Failed to update user: #{e.message}")
  end

  def create_user(request, _unused_call)
    user = User.create!(name: request.name, age: request.age)

    Rpc::CreateUserResponse.new(
      success: true,
      message: "User created successfully",
      id: user.id
    )
  rescue => e
    Rpc::CreateUserResponse.new(
      success: false,
      message: "Failed to create user: #{e.message}",
      id: 0
    )
  end
end

server = GRPC::RpcServer.new
server.add_http2_port("0.0.0.0:50051", :this_port_is_insecure)
server.handle(UserServer)
server.run_till_terminated
