class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @new_user = User.new(name: params[:name], password: params[:password])
    if @new_user.save
      render json: @new_user
    else
      render json: @new_user.errors
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(name: params[:name], password: params[:password])
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
