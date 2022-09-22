module Api
  module V1
    class StoryUpdater
    #class Api::V1::StoryUpdater
      def initialize
      end

      def successful?
        !!@successful
      end

      def call(id, story_params)
        story_update = Story.find(id)
        ActiveRecord::Base.transaction do
          @successful = story_update.update(story_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        story_update
      end

      def story
        @story
      end
    end
  end
end