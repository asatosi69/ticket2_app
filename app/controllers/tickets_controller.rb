class TicketsController < ApplicationController
  def index
      @tickets = Ticket.all
  end

  def new
      @ticket = Ticket.new
  end

  def create
      @ticket = Ticket.new(params_ticket)

      @ticket.save
      redirect_to("/tickets")
  end

  def edit
      @ticket = Ticket.find_by(id: params[:id])
  end

  def update
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.assign_attributes(params_ticket)
      
      @ticket.save
      redirect_to("/tickets")
  end
  
  def destroy
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.destroy
      
      redirect_to("/tickets")
  end
  
  private
   def params_ticket
    params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :buyer_mail, :comment1, :comment2)
   end
  
end
