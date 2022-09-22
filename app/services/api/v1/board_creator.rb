module Api
  module V1
    class BoardCreator
      def initialize
      end

      def successful?
        !!@successful
      end

      def call(board_params)
        board = Board.new(board_params)
        ActiveRecord::Base.transaction do
          @successful = board.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        board
      end
    end
  end
end