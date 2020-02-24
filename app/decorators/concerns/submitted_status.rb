class SubmittedStatus
  def initialize(decorator)
    @decorator = decorator
  end

  def status
    'មិនទាន់រួចរាល់'
  end

  def description
    "ឯកសារបានដាក់ពាក្យ នៅថ្ងៃ #{@decorator.submitted_at}"
  end
end
