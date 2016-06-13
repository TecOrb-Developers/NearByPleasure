#ActiveAdmin.register Ticket do

#	index do
 #   selectable_column
 #   id_column
 #   column :title
 #   column :content
 #   column :user_id
 #   actions
 # end
 # filter :title
#end

ActiveAdmin.register Ticket do
 config.breadcrumb = false
	index do
    selectable_column
    id_column
    column :title
    column :user_id
    actions
  end
  filter :title
  show do
  	attributes_table do
      row " " do |resources|
        render :partial => 'tickets/show',:locals=>{:@ticket=>resources,:@comments=>resources.ticket_comments}
        render :partial => 'ticket_comments/new',:locals=>{:@ticket=>resources,:@comments=>resources.ticket_comments}
       
      end
    end
  end

end

