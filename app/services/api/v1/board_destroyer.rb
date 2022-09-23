# frozen_string_literal: true

module Api
  module V1
    # board destroyer
    class BoardDestroyer
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(board)
        ActiveRecord::Base.transaction do
          @successful = board.destroy
          raise ActiveRecord::Rollback unless successful?
        end
        board
      end
    end
  end
end
