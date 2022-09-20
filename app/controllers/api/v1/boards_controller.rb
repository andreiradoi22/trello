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
        board = Board.new(board_params)
        creator = BoardCreator.new(board).run
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
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

      # def order_by_date
      #   boards = Board.order('created_at DESC');
      #   render json: {status: 'SUCCESS', message: 'Boards ordered by date', data: boards}, status: :ok
      # end

      # def order_by_name
      #   boards = Board.order('title CRESC');
      #   render json: {status: 'SUCCESS', message: 'Boards ordered by title', data: boards}, status: :ok
      # end

      private

      def board_params
        params.permit(:title, :body)
      end
    end
  end
end