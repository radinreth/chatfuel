import React from 'react'

class TextComponent extends React.Component {
  render() {
    return(
      <React.Fragment>
        <div className="form-group text optional template_content">
          <label className="text optional" htmlFor="template_content">Content</label>
          <textarea className="form-control text optional" name="template[content]" id="template_content"></textarea>
        </div>
      </React.Fragment>
    )
  }
}

export default TextComponent
