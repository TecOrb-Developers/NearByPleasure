class AddRatingsToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :rating, :string
    add_column :subcategories, :reviews, :string
  end
end
