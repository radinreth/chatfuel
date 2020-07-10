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
              image_aspect_ratio: "square",
              elements: [
                {
                  title: "ទីតាំងការិយាល័យច្រក",
                  subtitle: "សម្រាប់ពត៍មានបន្ថែមសូមចុចតំនរភ្ជាប់ខាងក្រោម 👇",
                  image_url: sample_map_image_url,
                  buttons: [
                    {
                      type: "web_url",
                      url: "https://www.google.com/maps/place/#{params[:location]}",
                      title: "មើលលើផែនទី!"
                    }
                  ]
                }
              ]
            }
          }
        }
      end

      def sample_map_image_url
        @sample_map_image_url ||= "https://dl.dropbox.com/s/0efkg615shrabhu/Google%20Maps%202020-07-10%2014-49-51.png?dl=0"
      end
  end
end
