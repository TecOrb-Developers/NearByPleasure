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
	end

	def show
		@user=User.find_by_id(params[:user_id])
		@ticket=@user.tickets.find_by_id(params[:ticket_id])
    @comments=TicketComment.all
	end
end
