module Api
  module V1
    class BoardUpdater
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(board: , board_params:)
        ActiveRecord::Base.transaction do
          @successful = board.update(board_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        board
      end

      def board
        @board
      end
    end
  end
end