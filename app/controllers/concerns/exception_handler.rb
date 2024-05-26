# Exception handler to handle different exceptions
module ExceptionHandler
  extend ActiveSupport::Concern

  class TokenInvalid < StandardError; end
  class NotFound < StandardError; end
  class LoginError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ExceptionHandler::TokenInvalid, with: :token_invalid
    rescue_from ExceptionHandler::NotFound, with: :not_found_error
    rescue_from ExceptionHandler::LoginError, with: :login_error
  end

  private

  def token_invalid
    render json: { error: 'Token invalid' }, code: '401', status: :unauthorized
  end

  def not_found_error
    render json: { error: 'Resource not found' }, code: '404', status: :not_found
  end

  def login_error
    render json: { error: 'Invalid credentials' }, code: '401', status: :unauthorized
  end
end
