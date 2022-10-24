require 'rails_helper'

RSpec.describe Board, type: :model do
  context "testing board model validations" do
    it 'when title is nil' do
      board = build(:board, title: nil)
      expect(board).to_not be_valid
    end

    it 'when body is nil' do
      board = build(:board, body: nil)
      expect(board).to_not be_valid
    end

    it 'when all attributes are completed' do
      board = build(:board, title: "Title", body: "Body")
      expect(board).to be_valid
    end
  end
end