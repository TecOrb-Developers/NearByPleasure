class AddIsBusinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_business, :boolean
  end
end
