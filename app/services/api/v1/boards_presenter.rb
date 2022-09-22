module Api
  module V1
    class BoardsPresenter
      def initialize()
      end

      def as_json(*)
        boards = []
        Board.all.each do |board|
          boards << { "title": board.title, "body": board.body }
        end
        {"boards": boards}
      end
    end
  end
end