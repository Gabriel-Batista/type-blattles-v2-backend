class MatchesController < ApplicationController
  def index
    @matches = Match.all
    render json: @matches
  end

  def show
    @match = Match.find(params[:id])
    render json: @match
  end

  def create
    @new_match = Match.new(seats: params[:seats])
    if @new_match.save
      render json: @new_match
    else
      render json: @new_match.errors
    end
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(seats_taken: params[:seats_taken])
      render json: @match
    else
      render json: @match.errors
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
  end
end
