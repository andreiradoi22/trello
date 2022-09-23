# frozen_string_literal: true

module Api
  module V1
    # column destroyer
    class ColumnDestroyer
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(column)
        ActiveRecord::Base.transaction do
          @successful = column.destroy
          raise ActiveRecord::Rollback unless successful?
        end
        column
      end
    end
  end
end
