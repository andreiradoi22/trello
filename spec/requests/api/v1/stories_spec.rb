require 'rails_helper'

RSpec.describe "Api::V1::StoriesController", type: :request do
  before do
    story = FactoryBot.create(:story)
  end
  
  describe "GET /api/v1/stories" do
    it "status 200 verification?" do
      get api_v1_stories_path
      expect(response).to have_http_status(200)
    end
  end
end