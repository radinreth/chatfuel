require 'liquid'

class LiquidScope
  def to_h
    { 'site' => { 'name' => 'KAMRIENG', 'province_name' => 'kandal' } }
  end
end

class PdfTemplateDecorator < ApplicationDecorator
  delegate_all

  def render
    template = Tilt::LiquidTemplate.new { content.body.html_safe }
    template.render(LiquidScope.new)
  end

end
