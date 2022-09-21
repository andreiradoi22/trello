module Api
  module V1
    class ColumnDestroyer
    #class Api::V1::ColumnDestroyer
      def initialize(column_id)
        @column_id = column_id
      end

      def successful?
        !!@successful
      end

      def call
        column = Column.find(@column_id)
        ActiveRecord::Base.transaction do
          @successful = column.destroy
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end