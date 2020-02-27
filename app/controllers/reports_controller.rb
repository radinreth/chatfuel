class ReportsController < ApplicationController
  def index
    @period = Period.new(params['dates'])

    @accessed = StepCollectionDecorator.new(:accessed, @period)
    @submitted = TicketCollectionDecorator.new(:submitted, @period)
    @completed = TicketCollectionDecorator.new(:completed, @period)

    @goals = [ @accessed, @submitted, @completed ]
  end
end
