class ManifestsController < ApplicationController
  def show
    authorize :manifest
  end
end
