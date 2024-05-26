# Exception handler to handle different exceptions
module ExceptionHandler
  extend ActiveSupport::Concern

  class TokenInvalid < StandardError; end
  class NotFound < StandardError; end

  included do
    # Define custom handlers
    rescue_from ExceptionHandler::TokenInvalid, with: :token_invalid
    rescue_from ExceptionHandler::NotFound, with: :not_found_error
  end

  private

  def token_invalid
    render json: { error: 'Token invalid' }, code: '401', status: :unauthorized
  end

  def not_found_error
    render json: { error: 'Resource not found' }, code: '404', status: :not_found
  end
end
