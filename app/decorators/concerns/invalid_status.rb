class InvalidStatus
  def initialize(decorator)
    @decorator = decorator
  end

  def status
    "លេខកូដឯកសារមិនមានក្នុងប្រព័ន្ធ"
  end

  def description
    "សូមត្រួតពិនិត្យ ហើយបញ្ចូលម្ដងទៀតនៅពេលក្រោយ"
  end
end