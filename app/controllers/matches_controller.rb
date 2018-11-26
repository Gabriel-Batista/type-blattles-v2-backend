# frozen_string_literal: true

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
    @new_match = Match.new(seats: params[:seats], paragraph: fetchNewParagraph)
    if @new_match.save
      render json: @new_match
    else
      render json: @new_match.errors
    end
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      match_complete
      broadcast_to_match(@match)
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
    @user = User.find_by(token: token)
    @matches = Match.where('seats_taken < 4')
    if @matches.empty? && @user.in_match == false
      create_match(@user)
    elsif @user.in_match == false
      join_match(@matches, @user)
    else
      render json: @user.matches.find_by(complete: false)
    end
  end

  def join_practice
    token = request.headers['Authorization'].match(/token=(.+)/)[1]
    @user = User.find_by(token: token)
    create_match(@user, 1)
  end

  private

  def match_params
    params.permit(:complete, :seats_taken, :practice)
  end

  def match_complete
    if @match.complete == true
      @match.users.each do |user|
        user.update(in_match: false)
      end
    end
  end

  def create_match(user, seats = 4)
    @paragraph = fetchNewParagraph
    @match = Match.create(paragraph: @paragraph[:quote], author: @paragraph[:author], seats: seats)
    @match.user_matches.create(user_id: user.id)
    user.update(in_match: true)
    render json: @match
  end

  def join_match(matches, user)
    @match = matches.all.first
    @match.user_matches.create(user_id: user.id)
    @match.update(seats_taken: @match.seats_taken + 1)
    @user.update(in_match: true)
    broadcast_to_match(@match)
    render json: @match
  end
end
