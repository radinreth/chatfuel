require 'liquid'

class PdfTemplateDecorator < ApplicationDecorator
  delegate_all

  def render(site)
    template = Tilt::LiquidTemplate.new { content.html_safe }
    template.render(LiquidServices::BaseLiquid.new(site))
  end

  def variables
    hashes.keys.each_with_object([]) do |k, arr|
      hashes[k].keys.each { |k2| arr << "{{#{k}.#{k2}}}" }
    end
  rescue
    []
  end

  private

  def hashes
    LiquidServices::BaseLiquid.new(Site.first).to_h
  end

end
