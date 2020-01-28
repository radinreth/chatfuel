xml.instruct!
xml.tag! 'verboice-service' do
  xml.name 'Health Center'
  xml.tag! 'global-settings' do
    xml.variable name: 'service_domain', 'display-name': 'Service Domain', type: 'string'
  end

  xml.steps do
    xml.step name: 'create', 'display-name': 'Create voice', icon: 'alert', type: 'callback', 'callback-url': 'http://{service_domain}/verboices/' do
      xml.settings do
        xml.variable name: 'input_birth', 'display-name': 'Input Birth', type: 'string'
        xml.variable name: 'main_option', 'display-name': 'Main Option', type: 'string'
      end

      xml.response type: 'variables' do
        xml.variable name: 'result', 'display-name': 'Result', type: 'string'
      end
    end
  end
end
