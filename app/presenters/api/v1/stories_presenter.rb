module Api
  module V1
    class StoriesPresenter
      def initialize(column_id)
        @column_id = column_id
      end

      def as_json(*)
        stories = []
        Story.all.where(column_id: @column_id).each do |story|
          stories << { "title": story.title, "description": story.description,
          "status": story.status, "due_date": story.due_date, "column_id": story.column_id }
        end
        {"stories": stories}
      end
    end
  end
end