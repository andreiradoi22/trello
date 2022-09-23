module Api
  module V1
    class StoriesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_board
      before_action :find_column
      before_action :find_story, only: [:show, :destroy, :update]

      def index
        stories = @column.stories
        stories = stories.filter_by_status([params[:status]]) if params[:status].present?
        stories = stories.filter_by_due_date([params[:due_date]]) if params[:due_date].present?
        stories_presenter = StoriesPresenter.new(stories)
        render json: stories_presenter.as_json, status: :ok
      end

      def show
        story_presenter = StoryPresenter.new(@story)
        render json: { story: story_presenter.as_json }, status: :ok
      end

      def create
        creator = StoryCreator.new
        story = creator.call(column: @column, story_params: story_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def destroy
        destroyer = StoryDestroyer.new
        story = destroyer.call(@story)
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      def update
        updater = StoryUpdater.new
        story = updater.call(story: @story, story_params: story_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { story: story }, status: status
      end

      private

      def story_params
        params.permit(:title, :description, :status, :due_date, :column_id)
      end

      def find_board
        @board = Board.find(params[:board_id])
      end

      def find_column
        @column = @board.columns.find(params[:column_id])
      end

      def find_story
        @story = @column.stories.find(params[:id])
      end
    end
  end
end