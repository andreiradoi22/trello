# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :error_404

  private

  def error_404
    render json: {}, status: :not_found
  end
end
