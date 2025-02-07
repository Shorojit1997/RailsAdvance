class TodosController < ApplicationController
  def index
    client = TodoClient.new
    @todos = client.list_todos
    render json: @todos
  end

  def show
    client = TodoClient.new
    @todo = client.get_todo(params[:id])
    render json: @todo
  end

  def create
    client = TodoClient.new
    @todo = client.create_todo(params[:title], params[:description], params[:completed])
    render json: @todo
  end

  def update
    client = TodoClient.new
    @todo = client.update_todo(params[:id], params[:title], params[:description], params[:completed])
    render json: @todo
  end

  def destroy
    client = TodoClient.new
    client.delete_todo(params[:id])
    head :no_content
  end
end