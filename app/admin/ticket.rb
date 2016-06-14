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
     #column "Business" do |resources|
       #resources.Subcategory.title
    #end

    actions
  end
  filter :title
  show do
  	attributes_table do
      row " " do |resources|
        render :partial => 'tickets/show',:locals=>{:@ticket=>resources,:@comments=>resources.ticket_comments,:@subcategory=> resources.subcategory}
        render :partial => 'ticket_comments/new',:locals=>{:@ticket=>resources,:@comments=>resources.ticket_comments}
       
      end
    end
  end
  controller do
    def show
      @ticket=Ticket.find_by_id(params[:id])
      @comments=@ticket.ticket_comments.order(created_at: "DESC")
    end
  end
end

