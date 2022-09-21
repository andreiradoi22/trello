module Api
  module V1
    class BoardCreator
    #class Api::V1::BoardCreator
      def initialize(board_params)
        @board_params = board_params
      end

      def successful?
        !!@successful
      end

      def call
        board = Board.new(@board_params)
        ActiveRecord::Base.transaction do
          @successful = board.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        board
      end
    end
  end
end