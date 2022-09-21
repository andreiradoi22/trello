require 'rails_helper'

RSpec.describe "Api::V1::BoardsController", type: :request do
  before do
    board = FactoryBot.create(:board)
  end

  describe "GET /api/v1/boards" do
    it "status 200 verification?" do
      get api_v1_boards_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(2)
    end
  end

  # describe "POST /api/v1/boards" do
  #   it "creating board" do
  #     post 
  #   end
  # end
end