class AddForgetPasswordTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forget_password_token, :string
  end
end
