module Api
  module V1
    # controller for auth
    class AuthController < ApplicationController
      # POST /api/v1/auth/signin
      def signin
        user = User.find_by(email: params[:auth][:email])
        raise ExceptionHandler::LoginError unless user.present? && user.password == (params[:auth][:password])

        token = JsonWebToken.encode(user_id: user.id, email: user.email)
        render json: user, token:, code: 200, status: :ok
      end
    end
  end
end
