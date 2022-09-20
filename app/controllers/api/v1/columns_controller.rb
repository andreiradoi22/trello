class Api::V1::ColumnsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    columns = Column.order('created_at DESC');
    render json: {status: 'SUCCESS', message: 'Loaded columns', data: columns}, status: :ok
  end

  def show
    column = Column.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded column', data: column}, status: :ok
  end

  def create
    column = Column.new(column_params)

    if column.save
      render json: {status: 'SUCCESS', message: 'Saved column', data: column}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Column not saved', data: column.errors}, status: unprocessable_entity
    end
  end

  def destroy
    column = Column.find(params[:id])
    column.destroy
    render json: {status: 'SUCCESS', message: 'Deleted column', data: column}, status: :ok
  end

  def update
    column = Column.find(params[:id])
    if column.update(column_params)
      render json: {status: 'SUCCESS', message: 'Updated column', data: column}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Column not updated', data: column.errors}, status: unprocessable_entity
    end
  end

  private

  def column_params
    params.permit(:title, :body)
  end
end