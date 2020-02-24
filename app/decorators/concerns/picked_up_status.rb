class PickedUpStatus
  def initialize(decorator)
    @decorator = decorator
  end

  def status
    'បានទទួល'
  end

  def description
    "ឯកសារបានទទួលរួចហើយ នៅថ្ងៃ #{@decorator.picked_up_at}"
  end
end
