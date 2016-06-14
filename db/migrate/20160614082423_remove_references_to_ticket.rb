class RemoveReferencesToTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :references, :string
  end
end
