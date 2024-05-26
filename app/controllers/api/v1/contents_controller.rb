# frozen_string_literal: true

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

      # PUT /api/v1/contents/:id
      def update
        content = current_user.contents.find_by(id: params[:id])
        raise ExceptionHandler::NotFound if content.blank?

        if content.update(content_params)
          render json: content, status: :ok
        else
          error = { error: content.errors }
          render json: error, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/contents/:id
      def destroy
        content = current_user.contents.find_by(id: params[:id])
        raise ExceptionHandler::NotFound if content.blank?

        content.destroy
        render json: { message: 'Deleted' }, status: :ok
      end

      private

      def content_params
        params.permit(:title, :body)
      end
    end
  end
end
