class BasicReport < Report
  def chart_options
    super.merge(colors: colors)
  end

  private
    def colors
      Color.generate(dataset&.count.to_i)
    end
end