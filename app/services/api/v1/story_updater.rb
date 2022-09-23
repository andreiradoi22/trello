module Api
  module V1
    class StoryUpdater
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(story: , story_params:)
        ActiveRecord::Base.transaction do
          @successful = story.update(story_params)
          raise ActiveRecord::Rollback unless self.successful?
        end
        story
      end

      def story
        @story
      end
    end
  end
end