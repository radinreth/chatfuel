class StepCollectionDecorator < BaseCollectionDecorator
  def collection
    Step.send(@sym)
  end
end
