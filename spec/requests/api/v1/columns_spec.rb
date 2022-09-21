require 'rails_helper'

RSpec.describe "Api::V1::ColumnsController", type: :request do
  describe "GET /api/v1/columns" do
    it "status 200 verification?" do
      get api_v1_columns_path
      expect(response).to have_http_status(200)
    end
  end

  # describe "GET /api/v1/columns/:id" do
  #   it "status 200" do
  #     column = create(:column)
  #     url = 'http://localhost:3000/api/v1/column/' + column.id.to_s
  #     get url
  #     expect(response).to have_http_status(200)
  #   end
  # end
end