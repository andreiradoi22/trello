module Api
  module V1
    class StoryPresenter
      def initialize(story)
        @story = story
      end

      def as_json(*)
        {
          "id": story.id, "title": @story.title, "description": @story.description,
          "status": @story.status, "due_date": @story.due_date, "column_id": @story.column_id
        }
      end
    end
  end
end
