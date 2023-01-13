class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :main_character
      t.string :secondary_character
      t.string :villian
      t.text :excerpt

      t.timestamps
    end
  end
end
