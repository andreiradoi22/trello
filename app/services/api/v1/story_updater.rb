module Api
  module V1
    class StoryUpdater
    #class Api::V1::StoryUpdater
      def initialize(story, story_params)
        @story = story
        @story_params = story_params
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @story.update(@story_params)

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end

      def story
        @story
      end
    end
  end
end