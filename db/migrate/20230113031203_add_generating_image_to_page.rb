class AddGeneratingImageToPage < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :generating_image, :boolean, default: false
  end
end
