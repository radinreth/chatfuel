class TicketsController < ApplicationController
  before_action :set_ticket, only: [:edit, :update, :destroy]

  def index
    @pagy, @tickets = pagy(Ticket.order(created_at: :desc))
    authorize @tickets
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to tickets_path, status: :created, notice: t("created.success") }
        format.js
        format.json { render json: @ticket, status: :created, location: @user }
      else
        format.html { render :new }
        format.js
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ticket.update(ticket_params)
    redirect_to tickets_path, status: :moved_permanently
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private
    def set_ticket
      @ticket ||= Ticket.find(params[:id])
      authorize(@ticket) && @ticket
    end

    def ticket_params
      status = params[:ticket][:status].to_i
      params.require(:ticket).permit(:code, :status).merge(status: status)
    end
end
