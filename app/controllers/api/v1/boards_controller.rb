module Api
  module V1
    class BoardsController < ApplicationController
    #class Api::V1::BoardsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        boards = Board.order(created_at: :desc);
        render json: {status: 'SUCCESS', message: 'Loaded boards', data: boards}, status: :ok
      end

      def show
        board = Board.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded board', data: board}, status: :ok
      end

      def create
        creator = BoardCreator.new(board_params).call
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { board: board_params }, status: status
      end

      def destroy
        board = Board.find(params[:id])
        destroyer = BoardDestroyer.new(board).run
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      def update
        board = Board.find(params[:id])
        updater = BoardUpdater.new(board, board_params).run
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { board: updater.board }, status: status
      end

      private

      def board_params
        params.permit(:title, :body)
      end
    end
  end
end