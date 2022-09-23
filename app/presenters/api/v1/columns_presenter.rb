# frozen_string_literal: true

module Api
  module V1
    # column index presenter
    class ColumnsPresenter
      def initialize(columns)
        @columns = columns
      end

      def columns
        columns = []
        @columns.each do |column|
          columns << {
            "title": column.title,
            "board_id": column.board_id
          }
        end
        columns
      end

      def as_json(*)
        {
          "columns": columns
        }
      end
    end
  end
end
