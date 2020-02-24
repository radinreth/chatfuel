class CompletedStatus
  def initialize(decorator)
    @decorator = decorator
  end
  
  def status
    'រួចរាល់'
  end

  def description
    "ឯកសារបានធ្វើរួចហើយ នៅថ្ងៃ #{@decorator.completed_at}"
  end
end
