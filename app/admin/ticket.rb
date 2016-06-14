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
  actions :all, except: [:edit, :destroy]
 config.breadcrumb = false
	index do
    selectable_column
    id_column
    column :title
    column :user_id
     column "Business" do |resources|
       resources.subcategory.present? ? resources.subcategory.title : "Not Available"
     end
    actions 
  end
  filter :title
  controller do
    def show
      @ticket=Ticket.find_by_id(params[:id])
      @comments=@ticket.ticket_comments.order(created_at: "DESC")
    end
  end
  show do
  	attributes_table do
      row " " do |resources|
        #render :partial => 'tickets/show',:locals=>{:@ticket=>resources,:@subcategory=> resources.subcategory}
        render :partial => 'ticket_comments/new',:locals=>{:@ticket=>resources,:@subcategory=> resources.subcategory}
        render :partial => 'tickets/show',:locals=>{:@ticket=>resources}  

      end
    end
  end
end
#:@comments=>resources.ticket_comments
#:@comments=>resources.ticket_comments