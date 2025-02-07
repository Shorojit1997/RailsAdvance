require "grpc"
require_relative "todo_services_pb"

class TodoServer < Todo::TodoService::Service
  def list_todos(_empty, _call)
    todos = Todo.all
    Todo::TodoList.new(todos: todos.map { |todo| map_todo_to_proto(todo) })
  end

  def get_todo(todo_request, _call)
    todo = Todo.find(todo_request.id)
    map_todo_to_proto(todo)
  end

  def create_todo(todo, _call)
    new_todo = Todo.create!(title: todo.title, description: todo.description, completed: todo.completed)
    map_todo_to_proto(new_todo)
  end

  def update_todo(todo, _call)
    existing_todo = Todo.find(todo.id)
    existing_todo.update!(title: todo.title, description: todo.description, completed: todo.completed)
    map_todo_to_proto(existing_todo)
  end

  def delete_todo(todo_request, _call)
    todo = Todo.find(todo_request.id)
    todo.destroy!
    Todo::Empty.new
  end

  private

  def map_todo_to_proto(todo)
    Todo::Todo.new(id: todo.id, title: todo.title, description: todo.description, completed: todo.completed)
  end
end
