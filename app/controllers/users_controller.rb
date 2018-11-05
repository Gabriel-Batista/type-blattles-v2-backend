class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:create], raise: false

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @new_user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if @new_user.save
      render json: { token: @new_user.token }
    else
      render json: @new_user.errors
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

    private

  def user_params
    params.require(:user).permit(:name, :password, :in_match)
  end
end
