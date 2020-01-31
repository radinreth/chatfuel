xml.instruct!
xml.tag! 'verboice-service' do
  xml.name 'OWSO app'
  xml.tag! 'global-settings' do
    xml.variable name: 'service_domain', 'display-name': 'Service Domain', type: 'string'
  end

  xml.steps do
    xml.step name: 'create', 'display-name': 'Create voice', icon: 'alert', type: 'callback', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'age', 'display-name': 'Age', type: 'string'
      end

      xml.response type: 'none'
    end
  end
end
