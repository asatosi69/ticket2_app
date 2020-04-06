class TicketsController < ApplicationController
  def index
      @tickets = Ticket.all
  end

  def new
      @ticket = Ticket.new
  end

  def create
      @Ticket = Ticket.new(params_ticket)
      @Ticket.save
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
    params.require(:ticket).permit(:name)
  end
end
