class AddFieldsToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :latitude, :float
    add_column :subcategories, :longitude, :float
    add_column :subcategories, :email, :string
  end
end
