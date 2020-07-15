require "rails_helper"

RSpec.describe Bots::Messages::MapPreviewController, type: :controller do
  let!(:site) { create(:site, name: "komrieng", lat: 1.0, lng: 1.2) }

  it "response" do
    get :index, params: { location: "komrieng" }

    expected = { messages: [{
                  attachment: {
                    type: "template",
                    payload: {
                      template_type: "generic",
                      image_aspect_ratio: "horizontal",
                      elements: [{
                        title: "OWSO office",
                        subtitle: "For more information, please click link below 👇",
                        image_url: "https://dl.dropbox.com/s/0efkg615shrabhu/Google%20Maps%202020-07-10%2014-49-51.png?dl=0",
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

    expect(JSON.parse(response.body)).to eq(expected.as_json)
  end
end
