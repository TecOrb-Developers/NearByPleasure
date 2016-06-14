class AddSubcategoryToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :subcategory, index: true, foreign_key: true
  end
end
