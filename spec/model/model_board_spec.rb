# require 'rails_helper'

# RSpec.describe Board, type: :model do
#   describe "POST /api/v1/boards" do

#     it "test the validation" do
#       headers = { 'ACCEPT' => 'application/json' }
#       url = 'http://localhost:3000/api/v1/boards/'
#       post url, :params => { title: '', body: '' }, :headers => headers
#       expect(response).to have_http_status(422)
#     end
#   end

#   it "x" do
#     board = create(:board, title: "TitluBoard1")
#     column = create(:column, title: "TitluColumn1", board_id: board.id)
#     story = create(:story, title: "TitluStory1", column_id: column.id)
#     expect(board.stories).to eq([story])
#   end
# end