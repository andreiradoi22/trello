module Api
  module V1
    class BoardsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        boards = BoardsPresenter.new
        render json: boards.as_json, status: :ok
      end

      def show
        board = BoardPresenter.new(params[:id])
        render json: { board: board.as_json }, status: board.status
      end

      def create
        creator = BoardCreator.new
        board = creator.call(board_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      def destroy
        destroyer = BoardDestroyer.new
        board = destroyer.call(params[:id])
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      def update
        updater = BoardUpdater.new
        board = updater.call(params[:id], board_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      private

      def board_params
        params.permit(:title, :body)
      end
    end
  end
end