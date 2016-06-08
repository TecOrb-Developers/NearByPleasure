class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :title
      t.string :profile_link
      t.string :contact
      t.text :description
      t.string :timing
      t.string :street_address
      t.string :city
      t.string :pin
      t.string :state
      t.string :page_url
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
