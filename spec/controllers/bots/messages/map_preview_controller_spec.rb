require "rails_helper"

RSpec.describe Bots::Messages::MapPreviewController, type: :controller do
  let!(:site) { create(:site, code: "0212", lat: 1.0, lng: 1.2) }

  it "response" do
    get :index, params: { location: "0212" }

    expected = { messages: [{
                  attachment: {
                    type: "template",
                    payload: {
                      template_type: "generic",
                      image_aspect_ratio: "horizontal",
                      elements: [{
                        title: "OWSO office",
                        subtitle: "For more information, please click link below 👇",
                        image_url: controller.helpers.asset_url("google-map-image-sample.png"),
                        buttons: [{
                          type: "web_url",
                          url: "https://www.google.com/maps/@1.0,1.2,18z",
                          title: "See on Map!"
                        }]
                      }]
                    }
                  }
                }]
              }

    expect(JSON.parse(response.body)).to include(expected.as_json)
  end
end
