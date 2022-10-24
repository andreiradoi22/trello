require 'rails_helper'

RSpec.describe Story, type: :model do
  context "testing story model validations" do
    it 'when title is nil' do
      story = build(:story, title: nil)
      expect(story).to_not be_valid
    end

    it 'when all attributes are completed' do
      story = build(:story, title: "Title")
      pp story
      expect(story).to be_valid
    end
  end

  context "testing story model relation" do
    it 'when story belongs to a column that belongs to a board' do
      board = create(:board, title: "BoardTitle", body: "BoardBody")
      column = create(:column, title: "ColumnTitle", board_id: board.id)
      story = create(:story, title: "StoryTitle", column_id: column.id)
      pp board
      pp column
      pp story
      expect(story).to be_valid
    end
  end
end