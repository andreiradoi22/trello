# frozen_string_literal: true

module Api
  module V1
    # board updater
    class BoardUpdater
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(board:, board_params:)
        ActiveRecord::Base.transaction do
          @successful = board.update(board_params)
          raise ActiveRecord::Rollback unless successful?
        end
        board
      end

      attr_reader :board
    end
  end
end
