class TicketCommentsController < ApplicationController
	def create
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:ticket_id])
		if @ticket
			@comment=TicketComment.create(:comment=>params[:comment][:comment],:user_id=>@user.id,:ticket_id=>@ticket.id)
			flash[:notice]="comment created"
			redirect_to :back
		else
			flash[:notice]="comment not send"
			redirect_to :back
			#redirect_to user_ticket_path(current_business_user,@ticket.id)
		end
		@ticket.update_attributes(:status=>false)
	end

	def show
		p "------------#{params.inspect}"
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:ticket_id])
		@admin=TicketComment.find_by_admin_id(nil)
    @comments=@ticket.ticket_comments
	end

	def create_admin_comment
		#@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:ticket_id])
		if @ticket
			@comment=TicketComment.create(:comment=>params[:comment][:comment],:admin_id=>nil,:ticket_id=>@ticket.id)
			flash[:notice]="comment created"
			redirect_to :back
		else
			flash[:notice]="comment not send"
			redirect_to :back
			#redirect_to user_ticket_path(current_business_user,@ticket.id)
		end
		@ticket.update_attributes(:status=>true)
	end 

end
