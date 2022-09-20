module Api
  module V1
    class BoardDestroyer
    #class Api::V1::BoardDestroyer
      def initialize(board)
        @board = board
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @board.destroy

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end