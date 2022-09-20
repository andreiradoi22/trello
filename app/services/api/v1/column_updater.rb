module Api
  module V1
    class ColumnUpdater
    #class Api::V1::ColumnUpdater
      def initialize(column, column_params)
        @column = column
        @column_params = column_params
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @column.update(@column_params)

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end

      def column
        @column
      end
    end
  end
end