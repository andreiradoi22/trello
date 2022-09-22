module Api
  module V1
    class ColumnCreator
    #class Api::V1::ColumnCreator
      def initialize
      end

      def successful?
        !!@successful
      end

      def call(column_params)
        column = Column.new(column_params)
        ActiveRecord::Base.transaction do
          @successful = column.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end