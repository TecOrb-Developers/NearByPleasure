class CreateTicketComments < ActiveRecord::Migration
  def change
    create_table :ticket_comments do |t|
      t.string :comment
      t.references :user, index: true, foreign_key: true
      t.references :ticket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
