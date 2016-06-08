class AddReviewToSubcategories < ActiveRecord::Migration
  def change
  	remove_column :subcategories,:reviews, :string
    add_column :subcategories, :review, :string
  end
end
