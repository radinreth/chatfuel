module Bots
  class MessagesController < BotsController
    before_action :set_variable, except: [:preview_map]
    before_action :set_message, except: [:preview_map]
    before_action :set_site, except: [:preview_map]
    before_action :set_step, except: [:preview_map]

    def done
      @message.completed! if params[:name] == "done" && params[:value] == "true"
      head :ok
    end

    def preview_map
      if params[:location]
        render json: { messages: [ gallery ] }, status: :ok
      else
        head :ok
      end
    end

    private
      def set_step
        @step = @message.steps.create(value: @variable_value)
        @step.update(site: @site) if @site
      end

      def set_site
        @site = Site.find_by(name: params["value"]) if params["name"] == "feedback_site"
      end

      def gallery
        @gallery ||= {
          attachment: {
            type: "template",
            payload: {
              template_type: "generic",
              image_aspect_ratio: "horizontal",
              elements: [
                {
                  title: I18n.t("chatfuel.map.title"),
                  subtitle: I18n.t("chatfuel.map.subtitle"),
                  image_url: ENV["SAMPLE_MAP_IMAGE"],
                  buttons: [
                    {
                      type: "web_url",
                      url: "https://www.google.com/maps/place/#{params[:location]}",
                      title: I18n.t("chatfuel.map.button_title")
                    }
                  ]
                }
              ]
            }
          }
        }
      end
  end
end
