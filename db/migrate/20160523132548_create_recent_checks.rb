class CreateRecentChecks < ActiveRecord::Migration
  def change
    create_table :recent_checks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
