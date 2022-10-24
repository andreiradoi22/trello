require 'rails_helper'

RSpec.describe Column, type: :model do
  context "testing column model validations" do
    it 'when title is nil' do
      column = build(:column, title: nil)
      expect(column).to_not be_valid
    end

    it 'when all attributes are completed' do
      column = build(:column, title: "Title")
      expect(column).to be_valid
    end
  end

  context "testing column model relation" do
    it 'when column belongs to a board' do
      board = create(:board, title: "BoardTitle", body: "BoardBody")
      column = create(:column, title: "ColumnTitle", board_id: board.id)
      expect(column).to be_valid
    end
  end
end