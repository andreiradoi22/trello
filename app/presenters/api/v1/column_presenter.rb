module Api
  module V1
    class ColumnPresenter
      def initialize(column)
        @column = column
      end

      def as_json(*)
        {
          "title": @column.title,
          "board_id": @column.board_id
        }
      end
    end
  end
end