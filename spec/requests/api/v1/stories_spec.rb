require 'rails_helper'

RSpec.describe "Api::V1::StoriesController", type: :request do
  describe "GET /api/v1/stories" do
    it "status 200 verification" do
      get api_v1_stories_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/stories/:id" do
    it "status 200" do
      story = create(:story)
      url = 'http://localhost:3000/api/v1/stories/' + story.id.to_s
      get url
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/stories" do
    it "creating sotry" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/stories/'
      post url, :params => { title: 'Title Test', description: 'Description Test', status: 'TO DO', due_date: '2022-12-12', column_id: 3 }, :headers => headers
      expect(response).to have_http_status(200)
    end

    it "verification new story" do
      cnt = Story.count
      story = FactoryBot.create(:story)
      url = 'http://localhost:3000/api/v1/stories/' + story.id.to_s
      get url
      expect(Story.count).to eq(cnt + 1)
    end

    it "error creating - missing inputs" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/stories/'
      post url, :params => { title: '', description: '', status: '', due_date: '', column_id: 3 }, :headers => headers
      expect(response).to have_http_status(422)
    end

    it "verify story attributes" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/stories/'
      post url, :params => { title: 'Title Test', description: 'Description Test', status: 'TO DO', due_date: '2022-12-12', column_id: 3 }, :headers => headers
      parsed1 = JSON.parse(response.body)["story"]["title"]
      expect(parsed1).to eq("Title Test")
      parsed2 = JSON.parse(response.body)["story"]["description"]
      expect(parsed2).to eq("Description Test")
      parsed3 = JSON.parse(response.body)["story"]["status"]
      expect(parsed3).to eq("TO DO")
      parsed4 = JSON.parse(response.body)["story"]["due_date"]
      expect(parsed4).to eq("2022-12-12T00:00:00.000Z")
      parsed5 = JSON.parse(response.body)["story"]["column_id"]
      expect(parsed5).to eq(3)
    end
  end

  describe "PUT /api/v1/stories" do
    it "updating story" do
      headers = { 'ACCEPT' => 'application/json' }
      story = create(:story)
      put "/api/v1/stories/#{story.id}", :params => {id: story.id, title: 'Title Test UPD', description: 'Description Test UPD', status: 'TO DO UPD', due_date: '2022-12-13', column_id: 3 }, :headers => headers
      expect(response).to have_http_status(200)
    end

    it "error updating - missing inputs" do
      headers = { 'ACCEPT' => 'application/json' }
      story = create(:story)
      put "/api/v1/stories/#{story.id}", :params => {id: story.id, title: '', description: '', status: '', due_date: '', column_id: 3 }, :headers => headers
      expect(response).to have_http_status(422)
    end

    it "updating story attributes" do
      headers = { 'ACCEPT' => 'application/json' }
      story = create(:story)
      put "/api/v1/stories/#{story.id}", :params => {id: story.id, title: 'Title Test UPD', description: 'Description Test UPD', status: 'TO DO UPD', due_date: '2022-12-13', column_id: 3 }, :headers => headers
      parsed1 = JSON.parse(response.body)["story"]["title"]
      expect(parsed1).to eq("Title Test UPD")
      parsed2 = JSON.parse(response.body)["story"]["description"]
      expect(parsed2).to eq("Description Test UPD")
      parsed3 = JSON.parse(response.body)["story"]["status"]
      expect(parsed3).to eq("TO DO UPD")
      parsed4 = JSON.parse(response.body)["story"]["due_date"]
      expect(parsed4).to eq("2022-12-13T00:00:00.000Z")
      parsed5 = JSON.parse(response.body)["story"]["column_id"]
      expect(parsed5).to eq(3)
    end
  end

  describe "DELETE /api/v1/stories" do
    it "deleting story" do
      headers = { 'ACCEPT' => 'application/json' }
      story = create(:story)
      delete "/api/v1/stories/#{story.id}"
      expect(response).to have_http_status(200)
    end
  end
end