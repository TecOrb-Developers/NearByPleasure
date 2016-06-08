ActiveAdmin.register User do

 permit_params :fname, :lname, :email, :contact, :gender
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
    selectable_column
    id_column
    column :fname
    column :lname
    column :email
    column :contact
    column :gender
    column :image
    column :is_confirm
    actions
  end
  filter :fname
  filter :lname
  filter :email

end
