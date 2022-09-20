require 'rails_helper'

describe Board, type: :request do
  describe 'GET /boards' do
    it 'returns all boards' do
      FactoryBot.create(:board, title: 'test1', body: "test1")
      FactoryBot.create(:board, title: 'test2', body: "test2")

      get '/api/v1/boards'

      expect(response).to have_http_status(:ok)
      #expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /boards' do
    it 'create new board' do
      post '/api/v1/boards', params: { board: {title: "title1created", body: "body1created"} }

      expect(response).to have_http_status(:ok)
    end
  end
end
