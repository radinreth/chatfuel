# TODO: add spec

class StepCollectionDecorator < BaseCollectionDecorator
  def collection
    Step.send(@sym)
  end

  def to_partial_path
    "steps/step"
  end
end
