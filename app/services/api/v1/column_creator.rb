module Api
  module V1
    class ColumnCreator
    #class Api::V1::ColumnCreator
      def initialize(column)
        @column = column
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @column.save

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end