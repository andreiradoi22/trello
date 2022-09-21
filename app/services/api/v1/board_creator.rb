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
        ActiveRecord::Base.transaction do
          @successful = Board.new(@board_params).save

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end