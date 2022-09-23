# frozen_string_literal: true

module Api
  module V1
    # column updater
    class ColumnUpdater
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(column:, column_params:)
        ActiveRecord::Base.transaction do
          @successful = column.update(column_params)
          raise ActiveRecord::Rollback unless successful?
        end
        column
      end

      attr_reader :column
    end
  end
end
