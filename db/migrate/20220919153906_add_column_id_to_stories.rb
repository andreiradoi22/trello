class AddColumnIdToStories < ActiveRecord::Migration[6.1]
  def change
    add_column :stories, :column_id, :integer
    add_index :stories, :column_id
  end
end
