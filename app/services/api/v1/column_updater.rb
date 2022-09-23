module Api
  module V1
    class ColumnUpdater
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(column: , column_params:)
        ActiveRecord::Base.transaction do
          @successful = column.update(column_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end

      def column
        @column
      end
    end
  end
end