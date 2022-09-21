require 'rails_helper'

RSpec.describe "Api::V1::StoriesController", type: :request do
  describe "GET /api/v1/stories" do
    before do
      story = FactoryBot.create(:story)
    end
    it "status 200 verification?" do
      get api_v1_stories_path
      expect(response).to have_http_status(200)
    end
  end
end