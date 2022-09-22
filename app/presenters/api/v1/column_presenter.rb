module Api
  module V1
    class ColumnPresenter
      def initialize(column_id)
        @column_id = column_id
        begin
          @column = Column.find(@column_id)
        rescue ActiveRecord::RecordNotFound
        end
      end

      def as_json(*)
        @column.nil? ? {} : { "title": @column.title, "board_id": @column.board_id }
      end

      def status
        @column.nil? ? :not_found : :ok
      end
    end
  end
end