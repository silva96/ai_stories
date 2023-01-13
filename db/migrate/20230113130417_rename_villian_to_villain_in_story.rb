class RenameVillianToVillainInStory < ActiveRecord::Migration[7.0]
  def change
    rename_column :stories, :villian, :villain
  end
end
