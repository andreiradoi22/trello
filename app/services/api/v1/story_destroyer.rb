module Api
  module V1
    class StoryDestroyer
    #class Api::V1::StoryDestroyer
      def initialize(story)
        @story = story
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @story.destroy

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end