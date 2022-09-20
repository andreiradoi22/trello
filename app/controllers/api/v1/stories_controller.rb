module Api
  module V1
    class StoriesController < ApplicationController
    #class Api::V1::StoriesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        stories = Story.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded stories', data: stories}, status: :ok
      end

      def show
        story = Story.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded story', data: story}, status: :ok
      end

      def create
        story = Story.new(story_params)
        creator = StoryCreator.new(story).run
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def destroy
        story = Story.find(params[:id])
        destroyer = StoryDestroyer.new(story).run
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def update
        story = Story.find(params[:id])
        updater = StoryUpdater.new(story, story_params).run
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { story: updater.story }, status: status
      end

      private

      def story_params
        params.permit(:title, :description, :status, :due_date, :column_id)
      end
    end
  end
end