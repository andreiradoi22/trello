# require 'rails_helper'

# RSpec.describe "Api::V1::StoriesController", type: :request do
#   describe "GET /api/v1/stories" do
#     it "status 200 verification?" do
#       get api_v1_stories_path
#       expect(response).to have_http_status(200)
#     end
#   end

#   describe "GET /api/v1/stories/:id" do
#     it "status 200 verification" do
#       story = FactoryBot.create(:story)
#       url = 'http://localhost:3000/api/v1/stories/' + story.id.to_s
#       get url
#       expect(response).to have_http_status(200)
#     end
#   end
# end