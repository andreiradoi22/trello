require 'rails_helper'

RSpec.describe "Api::V1::ColumnsController", type: :request do
  describe "GET /api/v1/columns" do
    before do
      column = FactoryBot.create(:column)
    end
    it "status 200 verification?" do
      get api_v1_columns_path
      expect(response).to have_http_status(200)
    end
  end
end