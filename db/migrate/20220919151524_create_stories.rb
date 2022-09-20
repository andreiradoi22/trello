class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :due_date

      t.timestamps
    end
  end
end
