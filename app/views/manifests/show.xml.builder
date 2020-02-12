xml.instruct!
xml.tag! 'verboice-service' do
  xml.name 'OWSO app'
  xml.tag! 'global-settings' do
    xml.variable name: 'service_domain', 'display-name': 'Service Domain', type: 'string'
  end

  xml.steps do
    xml.step name: 'api main', icon: 'gear', type: 'callback', 'display-name': 'Main menu', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'main_menu', 'display-name': 'main-menu', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api menu', icon: 'gear', type: 'callback', 'display-name': 'Menu options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'menu_options', 'display-name': 'menu-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api list', icon: 'gear', type: 'callback', 'display-name': 'List items', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'list_items', 'display-name': 'list-items', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api sub', 'display-name': 'Sub items', icon: 'gear', type: 'callback', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'sub_items', 'display-name': 'sub_items', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api detail', 'display-name': 'Item detail', icon: 'gear', type: 'callback', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'item_detail', 'display-name': 'item_detail', type: 'string'
      end
      xml.response type: 'none'
    end
  end
end
