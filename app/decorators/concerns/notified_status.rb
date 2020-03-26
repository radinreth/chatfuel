class NotifiedStatus
  def initialize(decorator)
    @decorator = decorator
  end
  
  def status
    "បានជូនដំណឹងរួច"
  end

  def description
    "ឯកសារបានធ្វើរួច និងបានជូនដំណឹង!"
  end
end