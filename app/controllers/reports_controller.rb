class ReportsController < ApplicationController
  before_action :ensure_date_range
  before_action :accessed, :submitted, :completed
  before_action :satisfied, :disatisfied

  def index
    @goals = [accessed, submitted, completed]
    @complaints = [satisfied, disatisfied]
  end

  private
    def accessed
      @accessed = StepCollectionDecorator.new(:accessed, period)
    end

    def submitted
      @submitted = TicketCollectionDecorator.new(:submitted, period)
    end

    def completed
      @completed = TicketCollectionDecorator.new(:completed, period)
    end

    def satisfied
      @satisfied = FeedbackCollectionDecorator.new(:satisfied, period)
    end

    def disatisfied
      @disatisfied = FeedbackCollectionDecorator.new(:disatisfied, period)
    end

    def period
      @period = Period.new(params["dates"])
    end

    def ensure_date_range
      redirect_to reports_path(dates: default_date_range) unless params["dates"]
    end

    def default_date_range
      past_date = 6.days.ago.strftime("%d/%m/%Y")
      current_date = Date.current.strftime("%d/%m/%Y")

      @default_date_range ||= "#{past_date} - #{current_date}"
    end
end
