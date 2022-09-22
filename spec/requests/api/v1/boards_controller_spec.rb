# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::BoardsController', type: :request do
  let(:board) { create(:board) }

  describe 'GET /index' do
    it 'status 200 verification' do
      get api_v1_boards_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/boards/:id' do
    it 'status 200' do
      get "http://localhost:3000/api/v1/boards/#{board.id}"
      expect(response).to have_http_status(200)
    end

    it 'status 404' do
      get "http://localhost:3000/api/v1/boards/8"
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /api/v1/boards' do
    it 'creating board' do
      headers = { 'ACCEPT' => 'application/json' }
      post 'http://localhost:3000/api/v1/boards/', params: { title: 'Title Test', body: 'Body Test' },
                                                   headers: headers
      expect(response).to have_http_status(200)
    end

    it 'verification new board' do
      cnt = Board.count
      get "http://localhost:3000/api/v1/boards/#{board.id}"
      expect(Board.count).to eq(cnt + 1)
    end

    it 'error creating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      post 'http://localhost:3000/api/v1/boards/', params: { title: '', body: '' }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'verify board attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      post 'http://localhost:3000/api/v1/boards/', params: { title: 'Title Test', body: 'Body Test' },
                                                   headers: headers
      parsed1 = JSON.parse(response.body)['board']['title']
      expect(parsed1).to eq('Title Test')
      parsed2 = JSON.parse(response.body)['board']['body']
      expect(parsed2).to eq('Body Test')
    end
  end

  describe 'PUT /api/v1/boards' do
    it 'updating board' do
      headers = { 'ACCEPT' => 'application/json' }
      put "/api/v1/boards/#{board.id}", params: { id: board.id, title: 'testupd', body: 'cevaupd' },
                                        headers: headers
      expect(response).to have_http_status(200)
    end

    it 'error updating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      put "/api/v1/boards/#{board.id}", params: { id: board.id, title: '', body: '' }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'updating board attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      put "/api/v1/boards/#{board.id}", params: { id: board.id, title: 'testupd', body: 'cevaupd' },
                                        headers: headers
      parsed1 = JSON.parse(response.body)['board']['title']
      expect(parsed1).to eq('testupd')
      parsed2 = JSON.parse(response.body)['board']['body']
      expect(parsed2).to eq('cevaupd')
    end
  end

  describe 'DELETE /api/v1/boards' do
    it 'deleting board' do
      delete "/api/v1/boards/#{board.id}"
      expect(response).to have_http_status(200)
    end
  end
end
