module PagyHelper
  def pagy_item_index(index)
    @pagy.from + index
  end
  
  def pagy_range
    "#{@pagy.from} - #{@pagy.to}"
  end
end
