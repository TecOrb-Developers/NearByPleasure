class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :content
      t.string :image
      t.references :user, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
