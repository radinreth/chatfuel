class QuotasController < ApplicationController
  def index
    # "https://graph.facebook.com/v3.0/105474597800095/insights/?metric=page_messages_total_messaging_connections&since=...&until=...&access_token=EAACnHokzay4BAIz5V7iw6nz7uyZCtk3XbdrM6dbcNyZA4W8kd4919w7HeZCp9JMwTTdaaUTZCtZCMLj3ubNWrx5ZAmfikCwUZClwsz0t1f6F7SP78qfBIlXzOmnBqFoXkPXV2gsogJfPguMXGU5TQfEXumohvqiREb6HgtZAh612vgZDZD"
    rest = RestClient.get "http://192.168.1.138:3001/data"
    @json = JSON.parse(rest.body)
  end

  private
    def messaging_connections
      json.find { |x| x["name"] == "page_total_messaging_connections" }
    end
end
