require 'rails_helper'

RSpec.describe "Api::V1::BoardsController", type: :request do
  describe "GET /api/v1/boards" do
    before do
      board = FactoryBot.create(:board)
    end
    it "status 200 verification?" do
      get api_v1_boards_path
      expect(response).to have_http_status(200)
    end
  end
end