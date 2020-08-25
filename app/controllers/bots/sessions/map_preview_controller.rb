# frozen_string_literal: true

module Bots::Sessions
  class MapPreviewController < ::BotsController
    before_action :set_site

    def index
      if @site.present?
        render json: { messages: [ gallery ] }, status: :ok
      else
        head :ok
      end
    end

    private
      def set_site
        @site = Site.find_by(code: params[:location])
      end

      # ref: https://docs.chatfuel.com/en/articles/735122-json-api
      def gallery
        {
          attachment: {
            type: "template",
            payload: {
              template_type: "generic",
              image_aspect_ratio: "horizontal",
              elements: [ map_element ]
            }
          }
        }
      end

      def map_element
        {
          title: I18n.t("chatfuel.map.title", district: @site.name_km),
          subtitle: I18n.t("chatfuel.map.subtitle"),
          image_url: helpers.asset_url("google-map-image-sample.png"),
          buttons: [
            {
              type: "web_url",
              url: @site.map_url,
              title: I18n.t("chatfuel.map.button_title")
            }
          ]
        }
      end
  end
end
