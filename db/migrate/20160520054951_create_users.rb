class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :gender
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
