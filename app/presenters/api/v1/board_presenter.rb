# frozen_string_literal: true

module Api
  module V1
    # board show presenter
    class BoardPresenter
      def initialize(board)
        @board = board
      end

      def as_json(*)
        {
          "title": @board.title,
          "body": @board.body
        }
      end
    end
  end
end
