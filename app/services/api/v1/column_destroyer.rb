module Api
  module V1
    class ColumnDestroyer
    #class Api::V1::ColumnDestroyer
      def initialize(column)
        @column = column
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @column.destroy

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end