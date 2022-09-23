# frozen_string_literal: true

module Api
  module V1
    # boards class
    class BoardsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_board, only: %i[show destroy update]

      def index
        boards_presenter = BoardsPresenter.new
        render json: boards_presenter.as_json, status: :ok
      end

      def show
        board_presenter = BoardPresenter.new(@board)
        render json: { board: board_presenter.as_json }, status: :ok
      end

      def create
        creator = BoardCreator.new
        board = creator.call(board_params: board_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      def destroy
        destroyer = BoardDestroyer.new
        board = destroyer.call(@board)
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      def update
        updater = BoardUpdater.new
        board = updater.call(board: @board, board_params: board_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { board: board }, status: status
      end

      private

      def board_params
        params.permit(:title, :body)
      end

      def find_board
        @board = Board.find(params[:id])
      end
    end
  end
end
