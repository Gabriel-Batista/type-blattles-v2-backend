class MatchesChannel < ApplicationCable::Channel
  def subscribed
    @match = Match.find(params[:match_id])
    stream_for @match
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
