class ProvincialUsageDecorator < ApplicationDecorator
  delegate_all

  def data
    [
      province_name,
      visits_count,
      unique_users_count,
      service_delivered_count,
      most_request
    ]
  end

  def most_request
    h.render MostRequestUsageComponent.new(item: most_request_service)
  end
end
