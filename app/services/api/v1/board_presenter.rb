module Api
  module V1
    class BoardPresenter
      def initialize(board_id)
        @board_id = Board.find(board_id)
      end

      def as_json(*)
        { "title": @board_id.title, "body": @board_id.body }
      end
    end
  end
end