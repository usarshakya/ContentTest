module Api
  module V1
    # controller for content
    class ContentsController < ApplicationController
      before_action :authenticate_user

      # GET /api/v1/content
      def index
        contents = Content.all
        render json: contents, status: :ok
      end

      # POST /api/v1/contents
      def create
        content = current_user.contents.new(content_params)
        if content.save
          render json: content, status: :created
        else
          error = { error: content.errors }
          render json: error, status: :unprocessable_entity
        end
      end

      private

      def content_params
        params.permit(:title, :body)
      end
    end
  end
end
