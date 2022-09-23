module Api
  module V1
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