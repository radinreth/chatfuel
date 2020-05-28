class QuotaJob < ApplicationJob
  queue_as :default

  def perform
    metric = %w(page_messages_total_messaging_connections).join(",")
    begin_of_day = DateTime.now.beginning_of_day.to_i
    end_of_day = DateTime.now.end_of_day.to_i

    begin
      fb_insight_url = "https://graph.facebook.com/v5.0/me/insights/?metric=#{metric}&since=#{begin_of_day}&until=#{end_of_day}&access_token=#{ENV['FB_ACCESS_TOKEN']}"
      response = RestClient.get fb_insight_url
      json = JSON.parse response
      connection = messaging_connections json
      if connection
        connection["values"][0]["value"]
      end
    rescue StandardError => e
      Rails.logger.info e.message
    end
  end

  private
    def messaging_connections(json)
      json.find { |x| x["name"] == "page_total_messaging_connections" }
    end
end
