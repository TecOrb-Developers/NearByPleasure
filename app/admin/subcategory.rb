ActiveAdmin.register Subcategory , :as => "Business" do
permit_params :title,:description,:email,:contact,:street_address,:city,:pin,:state,:tag_line,:category_id,:rating
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
    column :title
    column :city
    column :state
    column :pin
    column :category
    actions
  end

filter :title
filter :city
filter :state
filter :category

end
