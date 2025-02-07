require "grpc"
require_relative "todo_services_pb"

class TodoClient
  def initialize(host = "localhost:50051")
    @stub = Todo::TodoService::Stub.new(host, :this_channel_is_insecure)
  end

  def list_todos
    @stub.list_todos(Todo::Empty.new).todos
  end

  def get_todo(id)
    @stub.get_todo(Todo::TodoRequest.new(id: id))
  end

  def create_todo(title, description, completed)
    @stub.create_todo(Todo::Todo.new(title: title, description: description, completed: completed))
  end

  def update_todo(id, title, description, completed)
    @stub.update_todo(Todo::Todo.new(id: id, title: title, description: description, completed: completed))
  end

  def delete_todo(id)
    @stub.delete_todo(Todo::TodoRequest.new(id: id))
  end
end
