class ReportsController < ApplicationController
  before_action :accessed, :submitted, :completed
  before_action :satisfied, :disatisfied

  def index
    @goals = [accessed, submitted, completed]
    @complains = [satisfied, disatisfied]
  end

  private

  def accessed
    @accessed ||= StepCollectionDecorator.new(:accessed, aggregates_period)
  end

  def submitted
    @submitted ||= TicketCollectionDecorator.new(:submitted, aggregates_period)
  end

  def completed
    @completed ||= TicketCollectionDecorator.new(:completed, aggregates_period)
  end

  def satisfied
    @satisfied ||= FeedbackCollectionDecorator.new(:satisfied, complains_period)
  end

  def disatisfied
    @disatisfied ||= FeedbackCollectionDecorator.new(:disatisfied, complains_period)
  end

  def aggregates_period
    @aggregates_period ||= Period.new(params['dates_aggregates'])
  end

  def complains_period
    @complains_period ||= Period.new(params['dates_complains'])
  end
end
