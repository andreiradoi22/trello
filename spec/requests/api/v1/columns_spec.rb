# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ColumnsController', type: :request do
  let(:board) { create(:board) }
  let(:column) { create(:column) }

  describe 'GET /api/v1/columns' do
    it 'status 200 verification' do
      get "http://localhost:3000/api/v1/boards//#{board.id}/columns/"
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/columns/:id' do
    it 'status 200' do
      get "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/columns' do
    it 'creating column' do
      headers = { 'ACCEPT' => 'application/json' }
      post "http://localhost:3000/api/v1/boards//#{board.id}/columns/",
           params: { title: 'Title Test', board_id: 1 }, headers: headers
      expect(response).to have_http_status(200)
    end

    it 'verification new column' do
      cnt = Column.count
      get "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}"
      expect(Column.count).to eq(cnt + 1)
    end

    it 'error creating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      post "http://localhost:3000/api/v1/boards//#{board.id}/columns/",
           params: { title: '', board_id: 1 }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'verify column attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      post "http://localhost:3000/api/v1/boards//#{board.id}/columns/",
           params: { title: 'Title Test', board_id: 2 }, headers: headers
      parsed1 = JSON.parse(response.body)['column']['title']
      expect(parsed1).to eq('Title Test')
    end
  end

  describe 'PUT /api/v1/columns' do
    it 'updating column' do
      headers = { 'ACCEPT' => 'application/json' }
      put "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}",
          params: { id: column.id, title: 'testupd', board_id: 1 }, headers: headers
      expect(response).to have_http_status(200)
    end

    it 'error updating - missing inputs' do
      headers = { 'ACCEPT' => 'application/json' }
      put "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}",
          params: { id: column.id, title: '', board_id: 5 }, headers: headers
      expect(response).to have_http_status(422)
    end

    it 'updating column attributes' do
      headers = { 'ACCEPT' => 'application/json' }
      put "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}",
          params: { id: column.id, title: 'testupd', board_id: 1 }, headers: headers
      parsed1 = JSON.parse(response.body)['column']['title']
      expect(parsed1).to eq('testupd')
    end
  end

  describe 'DELETE /api/v1/columns' do
    it 'deleting column' do
      delete "http://localhost:3000/api/v1/boards//#{board.id}/columns/#{column.id}"
      expect(response).to have_http_status(200)
    end
  end
end
