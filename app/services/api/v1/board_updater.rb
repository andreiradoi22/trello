module Api
  module V1
    class BoardUpdater
    #class Api::V1::BoardUpdater
      def initialize(board, board_params)
        @board = board
        @board_params = board_params
      end

      def successful?
        !!@successful
      end

      def call
        board_update = Board.find(@board)
        ActiveRecord::Base.transaction do
          @successful = board_update.update(@board_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        board_update
      end

      def board
        @board
      end
    end
  end
end