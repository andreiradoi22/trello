# frozen_string_literal: true

module Api
  module V1
    # story destroyer
    class StoryDestroyer
      # def initialize
      #   FOR SERVICIES
      # end

      def successful?
        !!@successful
      end

      def call(story)
        ActiveRecord::Base.transaction do
          @successful = story.destroy
          raise ActiveRecord::Rollback unless successful?
        end
        story
      end
    end
  end
end
