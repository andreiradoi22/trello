module Api
  module V1
    class ColumnCreator
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(board: , column_params:)
        column = Column.new(column_params)
        column.board_id = board.id
        ActiveRecord::Base.transaction do
          @successful = column.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        column
      end
    end
  end
end