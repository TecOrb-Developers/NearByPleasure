class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.string :content
      t.integer :admin_id
      t.timestamps null: false
    end
  end
end
