require 'liquid'

class PdfTemplateDecorator < ApplicationDecorator
  delegate_all

  def render(site)
    template = Tilt::LiquidTemplate.new { content.body.html_safe }
    template.render(LiquidServices::BaseLiquid.new(site))
  end

end
