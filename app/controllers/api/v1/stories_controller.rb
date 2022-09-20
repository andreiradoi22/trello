class Api::V1::StoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    stories = Story.order('created_at DESC');
    render json: {status: 'SUCCESS', message: 'Loaded stories', data: stories}, status: :ok
  end

  def show
    story = Story.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded story', data: story}, status: :ok
  end

  def create
    story = Story.new(story_params)

    if story.save
      render json: {status: 'SUCCESS', message: 'Saved story', data: story}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Story not saved', data: story.errors}, status: unprocessable_entity
    end
  end

  def destroy
    story = Story.find(params[:id])
    story.destroy
    render json: {status: 'SUCCESS', message: 'Deleted story', data: story}, status: :ok
  end

  def update
    story = Story.find(params[:id])
    if story.update(story_params)
      render json: {status: 'SUCCESS', message: 'Updated story', data: story}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Story not updated', data: story.errors}, status: unprocessable_entity
    end
  end

  private

  def story_params
    params.permit(:title, :description, :status, :due_date, :column_id)
  end
end