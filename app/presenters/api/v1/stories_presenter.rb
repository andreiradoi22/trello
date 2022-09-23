module Api
  module V1
    class StoriesPresenter
      def initialize(stories)
        @stories = stories
      end

      def stories
        stories = []
        @stories.each do |story|
          stories << { 
            "id": story.id,
            "title": story.title,
            "description": story.description,
            "status": story.status,
            "due_date": story.due_date,
            "column_id": story.column_id
          }
        end
        stories
      end

      def as_json(*)
        {
          "stories": stories
        }
      end
    end
  end
end