import React from "react"
import StatusComponent from "./status_component"
import TextComponent from "./text_component"
import VoiceComponent from "./voice_component"

class TemplateForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      templateType: "MessengerTemplate"
    }
  }

  onTypeSelected = e => {
    this.setState({ templateType: e.target.value })
  }

  handleSubmit = e => {
    console.log("submit")
    e.preventDefault()
  }

  render () {
    let { templateType } = this.state
    let TypeBasedComponent = templateType == "VerboiceTemplate" ? VoiceComponent : TextComponent

    return (
      <React.Fragment>
        <form onSubmit={this.handleSubmit} className="simple_form new_template" id="new_template" acceptCharset="UTF-8">
          <div className="form-group select required template_type">
            <label className="select required" htmlFor="template_type">Type <abbr title="required">*</abbr></label>
            
            <select onChange={this.onTypeSelected} className="form-control select required" name="template[type]" id="template_type">
              <option value="MessengerTemplate">Messenger</option>
              <option value="TelegramTemplate">Telegram</option>
              <option value="VerboiceTemplate">Verboice</option></select>
            </div>

            <TypeBasedComponent />
            <StatusComponent />

            <button className="btn btn-secondary" data-dismiss="modal" type="button">Cancel</button>
            <input type="submit" name="commit" value="Create template" className="btn btn-primary" data-disable-with="Create template" />
        </form>
      </React.Fragment>
    );
  }
}

export default TemplateForm
