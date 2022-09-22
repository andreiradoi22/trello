module Api
  module V1
    class StoryPresenter
      def initialize(story_id)
        @story_id = Story.find(story_id)
      end

      def as_json(*)
        {
          "title": @story_id.title, "description": @story_id.description,
          "status": @story_id.status, "due_date": @story_id.due_date, "column_id": @story_id.column_id
        }
      end
    end
  end
end
