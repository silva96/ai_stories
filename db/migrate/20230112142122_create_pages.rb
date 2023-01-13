class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :story, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
