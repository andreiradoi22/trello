# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::StoriesController', type: :request do
  url = 'http://localhost:3000/api/v1/boards/'

  let(:board) { create(:board) }
  let(:column) { create(:column, board_id: board.id) }
  let(:story) { create(:story, column_id: column.id) }

  describe 'GET /api/v1/stories' do
    it 'status 200 verification' do
      get "#{url}/#{board.id}/columns//#{column.id}/stories/"
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/stories/:id' do
    it 'status 200' do
      get "#{url}/#{board.id}/columns//#{column.id}/stories/#{story.id}"
      expect(response).to have_http_status(200)
    end

    it 'status 404' do
      get "http://localhost:3000/api/v1/boards//#{board.id}/columns//#{column.id}/stories/96"
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /api/v1/stories' do
    it 'creating sotry' do
      headers = { 'ACCEPT' => 'application/json' }
      post "#{url}/#{board.id}/columns//#{column.id}/stories/",
           params: { title: 'Title Test', description: 'Description Test',
                     status: 'TO DO', due_date: '2022-12-12', column_id: 3 }, headers: headers
      expect(response).to have_http_status(200)
    end

    it 'verification new story' do
      cnt = Story.count
      get "#{url}/#{board.id}/columns//#{column.id}/stories/#{story.id}"
      expect(Story.count).to eq(cnt + 1)
    end

    it 'error creating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      post "#{url}/#{board.id}/columns//#{column.id}/stories/",
           params: { title: '', description: '', status: '', due_date: '', column_id: 3 }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'verify story attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      post "#{url}/#{board.id}/columns//#{column.id}/stories/",
           params: { title: 'Title Test', description: 'Description Test',
                     status: 'TO DO', due_date: '2022-12-12', column_id: 3 }, headers: headers
      parsed1 = JSON.parse(response.body)['story']['title']
      expect(parsed1).to eq('Title Test')
      parsed2 = JSON.parse(response.body)['story']['description']
      expect(parsed2).to eq('Description Test')
      parsed3 = JSON.parse(response.body)['story']['status']
      expect(parsed3).to eq('TO DO')
      parsed4 = JSON.parse(response.body)['story']['due_date']
      expect(parsed4).to eq('2022-12-12T00:00:00.000Z')
    end
  end

  describe 'PUT /api/v1/stories' do
    it 'updating story' do
      headers = { 'ACCEPT' => 'application/json' }
      put "#{url}/#{board.id}/columns//#{column.id}/stories//#{story.id}",
          params: { id: story.id, title: 'Title Test UPD', description: 'Description Test UPD',
                    status: 'TO DO UPD', due_date: '2022-12-13', column_id: 3 }, headers: headers
      expect(response).to have_http_status(200)
    end

    it 'error updating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      put "#{url}/#{board.id}/columns//#{column.id}/stories//#{story.id}",
          params: { id: story.id, title: '', description: '', status: '', due_date: '', column_id: 3 }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'updating story attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      put "#{url}/#{board.id}/columns//#{column.id}/stories//#{story.id}",
          params: { id: story.id, title: 'Title Test UPD', description: 'Description Test UPD',
                    status: 'TO DO UPD', due_date: '2022-12-13', column_id: 3 }, headers: headers
      parsed1 = JSON.parse(response.body)['story']['title']
      expect(parsed1).to eq('Title Test UPD')
      parsed2 = JSON.parse(response.body)['story']['description']
      expect(parsed2).to eq('Description Test UPD')
      parsed3 = JSON.parse(response.body)['story']['status']
      expect(parsed3).to eq('TO DO UPD')
      parsed4 = JSON.parse(response.body)['story']['due_date']
      expect(parsed4).to eq('2022-12-13T00:00:00.000Z')
    end
  end

  describe 'DELETE /api/v1/stories' do
    it 'deleting story' do
      delete "#{url}/#{board.id}/columns//#{column.id}/stories//#{story.id}"
      expect(response).to have_http_status(200)
    end
  end
end
