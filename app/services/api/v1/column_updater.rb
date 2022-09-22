module Api
  module V1
    class ColumnUpdater
    #class Api::V1::ColumnUpdater
      def initialize
      end

      def successful?
        !!@successful
      end

      def call(id, column_params)
        column_update = Column.find(id)
        ActiveRecord::Base.transaction do
          @successful = column_update.update(column_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        column_update
      end

      def column
        @column
      end
    end
  end
end