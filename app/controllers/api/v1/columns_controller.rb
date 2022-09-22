module Api
  module V1
    class ColumnsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def index
        columns = Board.find(params[:board_id]).columns
        render json: {status: 'SUCCESS', message: 'Loaded columns', data: columns}, status: :ok
      end

      def show
        column = Column.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded column', data: column}, status: :ok
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