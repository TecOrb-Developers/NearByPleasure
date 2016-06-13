class AddAdminIdToTicketComments < ActiveRecord::Migration
  def change
    add_column :ticket_comments, :admin_id, :integer
  end
end
