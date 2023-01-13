class AddNumberToPage < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :number, :integer
  end
end
