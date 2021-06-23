class ProvincialUsagesController < ApplicationController
  def index
    @provincial_usages = ProvincialUsage.all
  end
end
