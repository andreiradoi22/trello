module Api
  module V1
    class ColumnsController < ApplicationController
    #class Api::V1::ColumnsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        ordering = {}
        ordering[params[:sorted_by] || 'created_at'] = params[:order_by] || 'desc'
        columns = Column.order(ordering);
        render json: {status: 'SUCCESS', message: 'Loaded columns', data: columns}, status: :ok
      end

      def show
        column = Column.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded column', data: column}, status: :ok
      end

      def create
        creator = ColumnCreator.new(column_params)
        column = creator.call
        status = creator.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def destroy
        destroyer = ColumnDestroyer.new(params[:id])
        column = destroyer.call
        status = destroyer.successful? ? :ok : :unprocessable_entity
        render json: { column: column }, status: status
      end

      def update
        updater = ColumnUpdater.new(params[:id], column_params)
        column = updater.call
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