ActiveAdmin.register Ticket do

	index do
    selectable_column
    id_column
    column :title
    column :content
    column :user_id
    actions
  end
  filter :title
end
