class AddTagLineToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :tag_line, :string
  end
end
