module Api
  module V1
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
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end