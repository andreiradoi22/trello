module Api
  module V1
    class BoardDestroyer
    #class Api::V1::BoardDestroyer
      def initialize(board_id)
        @board_id = board_id
      end

      def successful?
        !!@successful
      end

      def call
        board = Board.find(@board_id)
        ActiveRecord::Base.transaction do
          @successful = board.destroy
          raise ActiveRecord::Rollback unless self.successful?
        end
        board
      end
    end
  end
end