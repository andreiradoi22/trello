module Api
  module V1
    class ColumnPresenter
      def initialize(column_id)
        @column_id = Column.find(column_id)
      end

      def as_json(*)
        { "title": @column_id.title, "board_id": @column_id.board_id }
      end
    end
  end
end