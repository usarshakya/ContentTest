module Api
  module V1
    # controller for users
    class UsersController < ApplicationController
      # POST /api/v1/users/signup
      def signup
        user = User.new(user_params)
        if user.save
          render json: user, status: :ok
        else
          error = { error: user.errors }
          render json: error, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :email, :password, :country)
      end
    end
  end
end
