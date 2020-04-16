class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to tickets_path
    else
      render :new
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to tickets_path
  end

  private
    def ticket_params
      status = params[:ticket][:status].to_i
      params.require(:ticket).permit(:code, :status).merge(status: status)
    end
end
