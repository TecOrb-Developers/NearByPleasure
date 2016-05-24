class CreateTalkUsers < ActiveRecord::Migration
  def change
    create_table :talk_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :talk, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
