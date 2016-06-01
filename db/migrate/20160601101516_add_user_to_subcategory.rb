class AddUserToSubcategory < ActiveRecord::Migration
  def change
    add_reference :subcategories, :user, index: true, foreign_key: true
  end
end
