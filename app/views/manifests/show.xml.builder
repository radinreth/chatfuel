xml.instruct!
xml.tag! "verboice-service" do
  xml.name "OWSO External Service App"

  xml.steps do
    xml.step name: "dict_variable", icon: "robot", type: "callback", "display-name": "Dictionary Variable", "callback-url": "/api/v1/ivrs" do
      xml.settings do
        xml.variable name: "name", "display-name": "name", type: "string"
        xml.variable name: "value", "display-name": "value", type: "string"
        xml.variable name: "platform_name", "display-name": "platform_name", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "tracking_audio", icon: "robot", type: "callback", "display-name": "Tracking Audio", "callback-url": "/api/v1/ivr_tracks" do
      xml.settings do
        xml.variable name: "code", "display-name": "code", type: "string"
      end
      xml.response type: "flow"
    end
  end
end