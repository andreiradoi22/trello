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
#       story = create(:story)
#       url = 'http://localhost:3000/api/v1/stories/' + story.id.to_s
#       get url
#       expect(response).to have_http_status(200)
#     end
#   end

#   describe "POST /api/v1/stories" do
#     it "creating sotry" do
#       headers = { 'ACCEPT' => 'application/json' }
#       url = 'http://localhost:3000/api/v1/stories/'
#       post url, :params => { title: 'Title Test', description: 'Description Test', status: 'TO DO', due_date: '2022-12-12', column_id: 3 }, :headers => headers
#       expect(response).to have_http_status(200)
#     end
#   end
# end