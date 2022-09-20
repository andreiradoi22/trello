module Api
  module V1
    class StoryCreator
    #class Api::V1::StoryCreator
      def initialize(story)
        @story = story
      end

      def successful?
        !!@successful
      end

      def run
        ActiveRecord::Base.transaction do
          @successful = @story.save

          raise ActiveRecord::Rollback unless self.successful?
        end
        self
      end
    end
  end
end