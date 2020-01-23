xml.instruct!
xml.tag! 'verboice-service' do
  xml.name 'Health Center'
  xml.tag! 'global-settings' do
    xml.variable name: 'service_domain', 'display-name': 'Service Domain', type: 'string'
  end

  xml.steps do
    xml.step name: 'create', 'display-name': 'Create voice', icon: 'alert', type: 'callback', 'callback-url': 'http://945d479f.ngrok.io/verboices/' do
      xml.settings

      xml.response type: 'none'
    end
  end

  xml.steps do
    xml.step name: 'results', 'display-name': 'Analysis Results', icon: 'alert', type: 'callback', 'callback-url': 'http://945d479f.ngrok.io/verboices/results' do
      xml.settings do
        xml.variable name: 'pin', 'display-name': 'Patient pin', type: 'string'
      end

      xml.response type: 'variables' do
        xml.variable name: 'result', 'display-name': 'Result', type: 'string'
      end
    end
  end

  xml.steps do
    xml.step name: 'available_dates', 'display-name': 'Available Appointment Dates', icon: 'medicalkit', type: 'callback', 'callback-url': 'http://945d479f.ngrok.io/verboices/available_dates' do
      xml.settings
      xml.response type: 'flow'
    end
  end

  xml.steps do
    xml.step name: 'make_appointment', 'display-name': 'Make Appoinment', icon: 'medicalkit', type: 'callback', 'callback-url': 'http://945d479f.ngrok.io/verboices/make_appointment' do
      xml.settings do
        xml.variable name: 'pin', 'display-name': 'Patient pin', type: 'string'
        xml.variable name: 'data_option', 'display-name': 'Date option', type: 'numeric'
      end
      xml.response type: 'none'
    end
  end

  xml.steps do
    xml.step name: 'appointments', 'display-name': 'Booked Appoinment', icon: 'medicalkit', type: 'callback', 'callback-url': 'http://945d479f.ngrok.io/verboices/appointments' do
      xml.settings do
        xml.variable name: 'pin', 'display-name': 'Patient pin', type: 'string'
      end
      xml.response type: 'flow'
    end
  end
end
