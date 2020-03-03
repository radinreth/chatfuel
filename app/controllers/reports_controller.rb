class ReportsController < ApplicationController
  before_action :accessed, :submitted, :completed
  before_action :satisfied, :disatisfied

  def index
    @goals = [accessed, submitted, completed]
    @complaints = [satisfied, disatisfied]
  end

  private

  def accessed
    @accessed ||= StepCollectionDecorator.new(:accessed, period)
  end

  def submitted
    @submitted ||= TicketCollectionDecorator.new(:submitted, period)
  end

  def completed
    @completed ||= TicketCollectionDecorator.new(:completed, period)
  end

  def satisfied
    @satisfied ||= FeedbackCollectionDecorator.new(:satisfied, period)
  end

  def disatisfied
    @disatisfied ||= FeedbackCollectionDecorator.new(:disatisfied, period)
  end

  def period
    @period ||= Period.new(params['dates'])
  end
end
