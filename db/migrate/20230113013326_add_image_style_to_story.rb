class AddImageStyleToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :image_style, :string
  end
end
