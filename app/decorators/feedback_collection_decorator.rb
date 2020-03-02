class FeedbackCollectionDecorator < BaseCollectionDecorator
  def collection
    Feedback.send(@sym)
  end

  def to_partial_path
    'tickets/ticket'
  end
end