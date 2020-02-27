class ReportsController < ApplicationController
  def index
    @accessed  = Step.where(act: 'owso_options').extending do
      def name
        'Accessed'
      end
    end
    @submitted = Ticket.submitted.extending do
      def name
        'Submitted'
      end
    end
    @completed = Ticket.completed.extending do
      def name
        'Completed'
      end
    end

    @goals = [ @accessed, @submitted, @completed]
  end
end
