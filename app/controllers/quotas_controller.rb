class QuotasController < ApplicationController
  def index
    @quota = Quotum.last
  end
end
