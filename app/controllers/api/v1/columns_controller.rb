# frozen_string_literal: true

module Api
  module V1
    # columns class
    class ColumnsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :find_board
      before_action :find_column, only: %i[show destroy update]

      def index
        columns = @board.columns
        columns_presenter = ColumnsPresenter.new(columns)
        render json: columns_presenter.as_json, status: :ok
      end

      def show
        column_presenter = ColumnPresenter.new(@column)
        render json: { column: column_presenter.as_json }, status: :ok
      end

      def create
        creator = ColumnCreator.new
        column = creator.call(board: @board, column_params: column_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def destroy
        destroyer = ColumnDestroyer.new
        column = destroyer.call(@column)
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def update
        updater = ColumnUpdater.new
        column = updater.call(column: @column, column_params: column_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      private

      def column_params
        params.permit(:title, :board_id)
      end

      def find_board
        @board = Board.find(params[:board_id])
      end

      def find_column
        @column = @board.columns.find(params[:id])
      end
    end
  end
end
