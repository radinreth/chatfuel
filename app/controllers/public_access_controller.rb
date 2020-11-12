class PublicAccessController < ApplicationController
  def current_user
    Guest.new
  end
end
