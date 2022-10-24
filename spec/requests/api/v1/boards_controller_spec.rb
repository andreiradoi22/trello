# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::BoardsController', type: :request do
  url = 'http://localhost:3000/api/v1/boards/'

  let(:board) { create(:board) }

  describe 'GET /index' do
    it 'status 200 verification' do
      get url
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/boards/:id' do
    it 'status 200' do
      get "#{url}/#{board.id}"
      expect(response).to have_http_status(200)
    end

    it 'status 404' do
      get "#{url}/8"
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST /api/v1/boards' do
    it 'creating board' do
      headers = { 'ACCEPT' => 'application/json' }
      post url.to_s, params: { title: 'Title Test', body: 'Body Test' },
                     headers: headers
      expect(response).to have_http_status(200)
    end

    it 'verification new board' do
      cnt = Board.count
      get "#{url}/#{board.id}"
      expect(Board.count).to eq(cnt + 1)
    end
  end

  describe 'PUT /api/v1/boards' do
    it 'updating board' do
      headers = { 'ACCEPT' => 'application/json' }
      put "#{url}/#{board.id}", params: { id: board.id, title: 'testupd', body: 'cevaupd' },
                                headers: headers
      expect(response).to have_http_status(200)
    end

    it 'error updating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      put "#{url}/#{board.id}", params: { id: board.id, title: '', body: '' }, headers: headers
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE /api/v1/boards' do
    it 'deleting board' do
      delete "#{url}/#{board.id}"
      expect(response).to have_http_status(200)
    end
  end
end
