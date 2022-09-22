module Api
  module V1
    class StoriesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        stories = StoriesPresenter.new(params[:column_id])
        render json: stories.as_json, status: :ok
      end

      def show
        story = StoryPresenter.new(params[:id])
        render json: { sotry: story.as_json }, status: story.status
      end

      def create
        creator = StoryCreator.new
        story = creator.call(story_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def destroy
        destroyer = StoryDestroyer.new
        story = destroyer.call(params[:id])
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def update
        updater = StoryUpdater.new
        story = updater.call(params[:id], story_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def filter_params
        params.fetch(:filter, {})
      end

      private

      def story_params
        params.permit(:title, :description, :status, :due_date, :column_id)
      end
    end
  end
end