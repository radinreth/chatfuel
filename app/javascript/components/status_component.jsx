import React from 'react'

class StatusComponent extends React.Component {
  constructor(props) {
    super(props)
    this.state = { audio: "" }
  }

  onChangeHandler = e => {
    let file = e.target.files[0]

    if( file ) {
      let data = new FormData()
      data.append('audio', file)
      console.log("data", data)
      // this.setState({ audio: data })
    }
  }

  render() {
    return(
      <React.Fragment>
        <fieldset className="form-group radio_buttons optional template_status form-group-valid">
          <legend className="col-form-label pt-0">Status</legend>
          <input type="hidden" name="template[status]" value="" />

          <div className="form-check">
            <input className="form-check-input is-valid radio_buttons optional" type="radio" value="0" name="template[status]" id="template_status_0" />
            <label className="form-check-label collection_radio_buttons" htmlFor="template_status_0">Incomplete</label>
          </div>
          
          <div className="form-check">
            <input className="form-check-input is-valid radio_buttons optional" type="radio" value="1" name="template[status]" id="template_status_1" />
            <label className="form-check-label collection_radio_buttons" htmlFor="template_status_1">Completed</label>
          </div>

          <div className="form-check">
            <input className="form-check-input is-valid radio_buttons optional" type="radio" value="2" name="template[status]" id="template_status_2" />
            <label className="form-check-label collection_radio_buttons" htmlFor="template_status_2">Incorrect</label>
          </div>
        </fieldset>
      </React.Fragment>
    )
  }
}

export default StatusComponent
