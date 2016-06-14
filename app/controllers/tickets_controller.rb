class TicketsController < ApplicationController
	
	def index
		@tickets=Ticket.all.order(status: "ASC")
	end

	def create
		@user=User.find_by_id(params[:user_id])
		@subcategory=Subcategory.find_by_id(params[:subcategory])
		p"------#{@subcategory}"
		if @user
			@ticket=Ticket.create(:title=>params[:ticket][:title],:content=>params[:ticket][:content],:user_id=>@user.id,:status=>false,:subcategory_id=>@subcategory.id)
			flash[:notice]="ticket created successfully"
      redirect_to	user_ticket_path(@user.id,@ticket.id)

			#redirect_to user_ticket_path(encrypt(@user.id),encrypt(@ticket.id))
		else
			flash[:notice]="ticket not generated"
      render 'new'
		end

	end
	
	def new
		@user=User.find_by_id(current_business_user)
		@subcategories=@user.subcategories
	end
	def show 
		#@user=User.find_by_id(decrypt(params[:user_id]))
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
		@comments=@ticket.ticket_comments.order(created_at: "DESC")
		@admin=TicketComment.find_by_admin_id(nil)
        @subcategory=Subcategory.find_by_id(@ticket.subcategory_id)
		
	end

	def edit
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
	end
	def update
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
		if @ticket
			@ticket.update_attributes(:title=>params[:ticket][:title],:content=>params[:ticket][:content])
			flash[:notice]="ticket updated successfully"
			redirect_to	user_ticket_path(@user.id,@ticket.id)
		else
			redirect_to edit_user_ticket_path(current_business_user,@ticket.id)
		end
	end
	def close_ticket 
		@ticket=Ticket.find_by_id(params[:ticket_id])
		@ticket.update_attributes(:status=>false)
		redirect_to :back
	end
end
