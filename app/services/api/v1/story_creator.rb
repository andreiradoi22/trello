module Api
  module V1
    class StoryCreator
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(column: , story_params:)
        story = Story.new(story_params)
        story.column_id = column.id
        ActiveRecord::Base.transaction do
          @successful = story.save
          raise ActiveRecord::Rollback unless self.successful?
        end
        story
      end
    end
  end
end