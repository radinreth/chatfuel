class InvalidStatus
  def initialize(decorator)
    @decorator = decorator
  end
  
  def status
    'លេខកូដឯកសារមិនត្រឹមត្រូវ'
  end

  def description
    "សូមត្រួតពិនិត្យ ហើយបញ្ចូលម្ដងទៀតនៅពេលក្រោយ"
  end
end