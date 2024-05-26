# frozen_string_literal: true

require 'jwt'

# app/controllers/concerns/json_web_token.rb
module JsonWebToken
  APP_SECRET = Rails.application.credentials[:APP_SECRET]

  def self.encode(payload)
    JWT.encode(payload, APP_SECRET, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, APP_SECRET, true, { algorithm: 'HS256' })
  rescue JWT::DecodeError, JWT::VerificationError
    raise ExceptionHandler::TokenInvalid
  end
end
