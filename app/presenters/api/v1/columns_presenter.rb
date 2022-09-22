module Api
  module V1
    class ColumnsPresenter
      def initialize(board_id)
        @board_id = board_id
      end

      def as_json(*)
        columns = []
        Column.all.where(board_id: @board_id).each do |column|
          columns << { "title": column.title, "board_id": column.board_id }
        end
        {"columns": columns}
      end
    end
  end
end