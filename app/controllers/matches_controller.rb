class MatchesController < ApplicationController
  before_action :require_login

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

  def join_game
    token = request.headers['Authorization'].match(/token=(.+)/)[1]
    @matches = Match.where('seats_taken < 4')
    @user = User.find_by(token: token)
    if @matches.empty? && @user.in_match == false
      @match = Match.create
      @match.user_matches.create(user_id: @user.id)
      @user.update(in_match: true)
      render json: @match
    elsif @user.in_match == false
      @match = @matches.all.first
      @match.user_matches.create(user_id: @user.id)
      @match.update(seats_taken: @match.seats_taken + 1)
      @user.update(in_match: true)
      broadcast_to_match(@match)
      render json: @match
    else
      render json: { error: 'User is already in a match' }, status: 400
    end
  end
end
