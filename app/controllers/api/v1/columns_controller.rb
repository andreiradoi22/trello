module Api
  module V1
    class ColumnsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        columns = ColumnsPresenter.new(params[:board_id])
        render json: columns.as_json, status: :ok
      end

      def show
        column = ColumnPresenter.new(params[:id])
        render json: { column: column.as_json }, status: column.status
      end

      def create
        creator = ColumnCreator.new
        column = creator.call(column_params)
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def destroy
        destroyer = ColumnDestroyer.new
        column = destroyer.call(params[:id])
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def update
        updater = ColumnUpdater.new
        column = updater.call(params[:id], column_params)
        status = updater.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      private

      def column_params
        params.permit(:title, :board_id)
      end
    end
  end
end