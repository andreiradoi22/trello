module Api
  module V1
    class ColumnDestroyer
    #class Api::V1::ColumnDestroyer
      def initialize
      end

      def successful?
        !!@successful
      end

      def call(column_id)
        column = Column.find(column_id)
        ActiveRecord::Base.transaction do
          @successful = column.destroy
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end