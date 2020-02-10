xml.instruct!
xml.tag! 'verboice-service' do
  xml.name 'OWSO app'
  xml.tag! 'global-settings' do
    xml.variable name: 'service_domain', 'display-name': 'Service Domain', type: 'string'
  end

  xml.steps do
    xml.step name: 'create', 'display-name': 'Create voice', icon: 'alert', type: 'callback', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'f1', 'display-name': 'choose services', type: 'string'
        xml.variable name: 'f11', 'display-name': 'owso info', type: 'string'
        xml.variable name: 'f12', 'display-name': 'feedback type', type: 'string'
        xml.variable name: 'f121', 'display-name': 'feedback value', type: 'string'
        xml.variable name: 'f13', 'display-name': 'tracking', type: 'string'
      end

      xml.response type: 'none'
    end
  end
end
