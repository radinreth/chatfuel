class GenericReport < Report
  def chart_options
    super.merge(labels: labels)
  end
end
