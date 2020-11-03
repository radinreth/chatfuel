class Array
  def compact_blank
    self.reject &:blank?
  end
end
