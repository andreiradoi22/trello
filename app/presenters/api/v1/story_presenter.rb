module Api
  module V1
    class StoryPresenter
      def initialize(story_id)
        @story_id = story_id
        begin 
          @story = Story.find(@story_id)
        rescue ActiveRecord::RecordNotFound
        end
      end

      def as_json(*)
        @story.nil? ? {} : {
          "title": @story.title, "description": @story.description,
          "status": @story.status, "due_date": @story.due_date, "column_id": @story.column_id
        }
      end

      def status
        @story.nil? ? :not_found : :ok
      end
    end
  end
end
