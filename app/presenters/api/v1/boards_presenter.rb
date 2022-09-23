module Api
  module V1
    class BoardsPresenter
      # def initialize
      #   FOR SERVICIES
      # end

      def boards
        boards = []
        Board.all.each do |board|
          boards << {
            "title": board.title,
            "body": board.body
          }
        end
        boards
      end

      def as_json(*)
        {
          "boards": boards
        }
      end
    end
  end
end