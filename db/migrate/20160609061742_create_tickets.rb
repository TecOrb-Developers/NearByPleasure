class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :content
      t.boolean :status
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
