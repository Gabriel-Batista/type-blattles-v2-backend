# frozen_string_literal: true

class ApplicationController < ActionController::Base
  #TODO: Figure out how to send CSRF token to react frontend
  skip_forgery_protection
  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def broadcast_to_match(match)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      MatchSerializer.new(match)
    ).serializable_hash
    MatchesChannel.broadcast_to(match, serialized_data)
  end

  def fetchNewParagraph
    @response = Excon.get('http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=10')
    @paragraph_options = JSON.parse(@response.body).select do |paragraph|
      match_data = paragraph['content'].match(/\&\#([0-9]+)\;/)
      match_data.nil?
    end
    @paragraph_options.first['content'].gsub(/<\/?p>\s?+/, '').gsub('\n', '').tr('’', '\'').strip
    # /&#([0-9]+);/ <== replace apostrophe with single quote
  end


  protected

  def render_unauthorized(message)
    errors = { errors: [{ detail: message }] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      User.find_by(token: token)
    end
  end
end
