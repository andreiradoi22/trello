module Api
  module V1
    class BoardCreator
    #class Api::V1::BoardCreator
      def initialize(board)
        @board = board
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @board.save

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end