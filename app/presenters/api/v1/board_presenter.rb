module Api
  module V1
    class BoardPresenter
      def initialize(board_id)
        @board_id = board_id
        begin
          @board = Board.find(@board_id)
        rescue ActiveRecord::RecordNotFound
        end
      end

      def as_json(*)
        @board.nil? ? {} : { "title": @board.title, "body": @board.body }
      end

      def status
        @board.nil? ? :not_found : :ok
      end
    end
  end
end