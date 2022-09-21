module Api
  module V1
    class StoryCreator
    #class Api::V1::StoryCreator
      def initialize(story_params)
        @story_params = story_params
      end

      def successful?
        !!@successful
      end

      def call
        story = Story.new(@story_params)
        ActiveRecord::Base.transaction do
          @successful = story.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        story
      end
    end
  end
end