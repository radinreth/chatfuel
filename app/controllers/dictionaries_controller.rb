class DictionariesController < ApplicationController
  def index
    @variables = Variable.order(name: 'asc')
  end
end
