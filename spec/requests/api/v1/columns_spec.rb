require 'rails_helper'

RSpec.describe "Api::V1::ColumnsController", type: :request do
  describe "GET /api/v1/columns" do
    it "status 200 verification" do
      get api_v1_columns_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/columns/:id" do
    it "status 200" do
      column = create(:column)
      url = 'http://localhost:3000/api/v1/columns/' + column.id.to_s
      get url
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/columns" do
    it "creating column" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/columns/'
      post url, :params => { title: 'Title Test', board_id: 1 }, :headers => headers
      expect(response).to have_http_status(200)
    end

    it "verification new column" do
      cnt = Column.count
      column = create(:column)
      url = 'http://localhost:3000/api/v1/columns/' + column.id.to_s
      get url
      expect(Column.count).to eq(cnt + 1)
    end

    it "error creating - missing inputs" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/columns/'
      post url, :params => { title: '', board_id: 1 }, :headers => headers
      expect(response).to have_http_status(422)
    end

    it "verify column attributes" do
      headers = { 'ACCEPT' => 'application/json' }
      url = 'http://localhost:3000/api/v1/columns/'
      post url, :params => { title: 'Title Test', board_id: 2 }, :headers => headers
      parsed1 = JSON.parse(response.body)["column"]["title"]
      expect(parsed1).to eq("Title Test")
      parsed2 = JSON.parse(response.body)["column"]["board_id"]
      expect(parsed2).to eq(2)
    end
  end

  describe "PUT /api/v1/columns" do
    it "updating column" do
      headers = { 'ACCEPT' => 'application/json' }
      column = create(:column)
      put "/api/v1/columns/#{column.id}", :params => {id: column.id, title: 'testupd', board_id: 1 }, :headers => headers
      puts JSON.parse(response.body)
      expect(response).to have_http_status(200)
    end

    it "error updating - missing inputs" do
      headers = { 'ACCEPT' => 'application/json' }
      column = create(:column)
      put "/api/v1/columns/#{column.id}", :params => {id: column.id, title: '', board_id: 5 }, :headers => headers
      expect(response).to have_http_status(422)
    end

    it "updating column attributes" do
      headers = { 'ACCEPT' => 'application/json' }
      column = create(:column)
      put "/api/v1/columns/#{column.id}", :params => {id: column.id, title: 'testupd', board_id: 1 }, :headers => headers
      parsed1 = JSON.parse(response.body)["column"]["title"]
      expect(parsed1).to eq("testupd")
      parsed2 = JSON.parse(response.body)["column"]["board_id"]
      expect(parsed2).to eq(1)
    end
  end

  describe "DELETE /api/v1/columns" do
    it "deleting column" do
      headers = { 'ACCEPT' => 'application/json' }
      column = create(:column)
      delete "/api/v1/columns/#{column.id}"
      expect(response).to have_http_status(200)
    end
  end
end