module Api
  module V1
    class ColumnCreator
    #class Api::V1::ColumnCreator
      def initialize(column_params)
        @column_params = column_params
      end

      def successful?
        !!@successful
      end

      def call
        column = Column.new(@column_params)
        ActiveRecord::Base.transaction do
          @successful = column.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end