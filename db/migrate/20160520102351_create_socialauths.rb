class CreateSocialauths < ActiveRecord::Migration
  def change
    create_table :socialauths do |t|
      t.string :provider_id
      t.string :provider_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
