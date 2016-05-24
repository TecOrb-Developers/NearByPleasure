class AddContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact, :string
    add_column :users, :confirmation_token, :string
    add_column :users, :is_confirm, :boolean
  end
end
