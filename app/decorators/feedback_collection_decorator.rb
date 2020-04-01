class FeedbackCollectionDecorator < BaseCollectionDecorator
  def collection
    StepValue.send(@sym)
  end

  def to_partial_path
    "tickets/ticket"
  end
end
