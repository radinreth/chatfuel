xml.instruct!
xml.tag! "verboice-service" do
  xml.name "OWSO app"
  xml.tag! "global-settings" do
    xml.variable name: "service_domain", "display-name": "Service Domain", type: "string"
  end

  xml.steps do
    xml.step name: "api main", icon: "gear", type: "callback", "display-name": "Main menu", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "main_menu", "display-name": "main-menu", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api owso", icon: "gear", type: "callback", "display-name": "OWSO options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "owso_options", "display-name": "owso-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api certify", icon: "gear", type: "callback", "display-name": "certify options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "certify_options", "display-name": "certify-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api others", icon: "gear", type: "callback", "display-name": "other options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "other_options", "display-name": "other-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api hotpots", icon: "gear", type: "callback", "display-name": "hotpot options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "hotpot_options", "display-name": "hotpot-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api electronics", icon: "gear", type: "callback", "display-name": "electronic options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "electronic_options", "display-name": "electronic-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api barbers", icon: "gear", type: "callback", "display-name": "barber options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "barber_options", "display-name": "barber-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api choose office", icon: "gear", type: "callback", "display-name": "choose office options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "choose_office_options", "display-name": "choose-office-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api feedback overall", icon: "gear", type: "callback", "display-name": "feedback overall options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "feedback_overall_options", "display-name": "feedback-overall-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api difficulty", icon: "gear", type: "callback", "display-name": "difficulty options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "difficulty_options", "display-name": "difficulty-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api difficulty level", icon: "gear", type: "callback", "display-name": "difficulty level options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "difficulty_level_options", "display-name": "difficulty-level-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api work efficiency", icon: "gear", type: "callback", "display-name": "work efficiency options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "work_efficiency_options", "display-name": "work-efficiency-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api working time", icon: "gear", type: "callback", "display-name": "working time options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "working_time_options", "display-name": "working-time-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api attitude", icon: "gear", type: "callback", "display-name": "attitude options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "attitude_options", "display-name": "attitude-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api provide info", icon: "gear", type: "callback", "display-name": "provide info options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "provide_info_options", "display-name": "provide-info-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api process", icon: "gear", type: "callback", "display-name": "process options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "process_options", "display-name": "process-options", type: "string"
      end
      xml.response type: "none"
    end

    # old
    xml.step name: "api feedback", icon: "gear", type: "callback", "display-name": "Feedback options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "feedback_options", "display-name": "feedback-options", type: "string"
      end
      xml.response type: "none"
    end

    # old
    xml.step name: "api feedback rating", icon: "gear", type: "callback", "display-name": "Feedback rating options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "feedback_rating_options", "display-name": "feedback-rating-options", type: "string"
      end
      xml.response type: "none"
    end

    # old
    xml.step name: "api feedback record", icon: "gear", type: "callback", "display-name": "Feedback record options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "feedback_record_options", "display-name": "feedback-record-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api tracking ticket", icon: "gear", type: "callback", "display-name": "Tracking ticket", "callback-url": "http://{service_domain}/tracks/" do
      xml.settings do
        xml.variable name: "klass", "display-name": "ivr-class", type: "string"
        xml.variable name: "code", "display-name": "ticket-number", type: "string"
        xml.variable name: "tracking_ticket", "display-name": "tracking-ticket", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api menu", icon: "gear", type: "callback", "display-name": "Menu options", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "menu_options", "display-name": "menu-options", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api list", icon: "gear", type: "callback", "display-name": "List items", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "list_items", "display-name": "list-items", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api sub", "display-name": "Sub items", icon: "gear", type: "callback", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "sub_items", "display-name": "sub_items", type: "string"
      end
      xml.response type: "none"
    end

    xml.step name: "api detail", "display-name": "Item detail", icon: "gear", type: "callback", "callback-url": "http://{service_domain}/voice_messages/" do
      xml.settings do
        xml.variable name: "item_detail", "display-name": "item_detail", type: "string"
      end
      xml.response type: "none"
    end
  end
end
