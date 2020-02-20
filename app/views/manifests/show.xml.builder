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

    xml.step name: 'api owso', icon: 'gear', type: 'callback', 'display-name': 'OWSO options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'owso_options', 'display-name': 'owso-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api certify', icon: 'gear', type: 'callback', 'display-name': 'certify options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'certify_options', 'display-name': 'certify-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api others', icon: 'gear', type: 'callback', 'display-name': 'other options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'other_options', 'display-name': 'other-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api feedback', icon: 'gear', type: 'callback', 'display-name': 'Feedback options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'feedback_options', 'display-name': 'feedback-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api feedback rating', icon: 'gear', type: 'callback', 'display-name': 'Feedback rating options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'feedback_rating_options', 'display-name': 'feedback-rating-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api feedback record', icon: 'gear', type: 'callback', 'display-name': 'Feedback record options', 'callback-url': 'http://{service_domain}/voice_messages/' do
      xml.settings do
        xml.variable name: 'feedback_record_options', 'display-name': 'feedback-record-options', type: 'string'
      end
      xml.response type: 'none'
    end

    xml.step name: 'api tracking ticket', icon: 'gear', type: 'callback', 'display-name': 'Tracking ticket', 'callback-url': 'http://{service_domain}/tracks/' do
      xml.settings do
        xml.variable name: 'klass', 'display-name': 'ivr-class', type: 'string'
        xml.variable name: 'code', 'display-name': 'ticket-number', type: 'string'
        xml.variable name: 'tracking_ticket', 'display-name': 'tracking-ticket', type: 'string'
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
