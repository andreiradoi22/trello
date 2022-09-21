module Api
  module V1
    class StoryFilter
      def initialize(board)
        @board = board
      end

      def status_filter (status_p)
        @status_p = status_p
        self
      end

      def status_due_date (due_date_p)
        @due_date_p = due_date_p
        self
      end

      def call
        col_board = Column.where(board: @board)
        stories = Story.joins(:column)
                  .merge(col_board)
                  .where(@status_p.present? ? {status: [@status_p.split(',')]} : Arel.sql("1=1"))
                  .where(@due_date_p.present? ? {due_date: [@due_date_p.split(',')]} : Arel.sql("1=1"))
      end
    end
  end
end