module Api
  module V1
    class StoriesController < ApplicationController
    #class Api::V1::StoriesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        stories = Story.order(created_at: :desc)
        render json: {status: 'SUCCESS', message: 'Loaded stories', data: stories}, status: :ok
      end

      def show
        story = Story.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded story', data: story}, status: :ok
      end

      def create
        creator = StoryCreator.new(story_params)
        story = creator.call
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def destroy
        destroyer = StoryDestroyer.new(params[:id])
        story = destroyer.call
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def update
        updater = StoryUpdater.new(params[:id], story_params)
        story = updater.call
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      private

      def story_params
        params.permit(:title, :description, :status, :due_date, :column_id)
      end
    end
  end
end