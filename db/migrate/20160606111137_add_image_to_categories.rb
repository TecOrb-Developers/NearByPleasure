class AddImageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image, :string
  end
end
