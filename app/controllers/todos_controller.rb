class TodosController < ApplicationController

  def index
    todo = Todo.all
    render json: todo, status: :ok
  end

  def show
    todo = Todo.find(params[:id])
    render json: todo, status: :ok
  end

  def create
    todo = Todo.create!(todo_params)
    head :created, location: todo_url(todo)
  end

  def update
    todo = Todo.find(params[:id])
    todo.update(todo_params)
    head :no_content, location: todo_url(todo)
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content
  end

  private
  def todo_params
    params.permit(:title, :created_by)
  end
end
