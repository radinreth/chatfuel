import React from 'react'

class VoiceComponent extends React.Component {
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
        <div className="form-group file optional template_audio">
          <label className="file optional" htmlFor="template_audio">Audio</label>
          <input className="form-control-file file optional" type="file" name="template[audio]" id="template_audio" />
        </div>
      </React.Fragment>
    )
  }
}

export default VoiceComponent
