class CarsController < ApplicationController
  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def create
    @new_car = Car.new(img: params[:img])
    if @new_car.save
      render json: @new_car
    else
      render json: @new_car.errors
    end
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(img: params[:img])
      render json: @car
    else
      render json: @car.errors
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
  end
end
