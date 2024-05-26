# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :underscore_params!

  attr_accessor :current_user

  def authenticate_user
    @current_user = session_user
  end

  private

  def session_user
    header = request.headers['Authorization']
    token = header&.split(' ')&.last if header.present?
    raise ExceptionHandler::AuthenticationError unless token

    decoded = JsonWebToken.decode(token)
    user = User.find_by(id: decoded[0]['user_id'], email: decoded[0]['email'])
    raise ExceptionHandler::TokenInvalid if user.blank?

    user
  rescue JWT::DecodeError
    raise ExceptionHandler::TokenInvalid
  end

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
