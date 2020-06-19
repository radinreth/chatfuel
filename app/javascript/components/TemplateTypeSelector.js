import React from "react"
import PropTypes from "prop-types"
import TextComponent from './text_component'
import VoiceComponent from './voice_component'

class TemplateTypeSelector extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      templateName: ""
    }
  }

  onTypeSelected = (e) => {
    this.setState({ templateName: e.target.value })
  }

  render () {
    let TypeBasedComponent = TextComponent
    if( this.state.templateName == 'VerboiceTemplate' ) {
      TypeBasedComponent = VoiceComponent
    }

    return (
      <React.Fragment>
        <div className="form-group select required template_type">
          <label className="select required" htmlFor="template_type">Type <abbr title="required">*</abbr></label>
          <select onChange={this.onTypeSelected} className="form-control select required" name="template[type]" id="template_type">
            <option value="MessengerTemplate">Messenger</option>
            <option value="TelegramTemplate">Telegram</option>
            <option value="VerboiceTemplate">Verboice</option>
          </select>
        </div>

        <TypeBasedComponent />
      </React.Fragment>
    );
  }
}

export default TemplateTypeSelector
