module Api
  module V1
    class StoryDestroyer
    #class Api::V1::StoryDestroyer
      def initialize(story_id)
        @story_id = story_id
      end

      def successful?
        !!@successful
      end

      def call
        story = Story.find(@story_id)
        ActiveRecord::Base.transaction do
          @successful = story.destroy
          raise ActiveRecord::Rollback unless self.successful?
        end
        story
      end
    end
  end
end