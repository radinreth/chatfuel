import React from 'react'
import axios from 'axios'

class Site extends React.Component {
  constructor(props) {
    super(props)
    this.state = { sites: [] }
  }

  getSites() {
    axios.get('/sites.json')
      .then((response) => {
        this.setState({
          sites: response.data
        })
      })
      .catch((err) => {
        console.log(err)
      })
  }

  async componentDidMount() {
    this.getSites()
  }

  render() {
    return(
      <>
        <label className="select optional mt-3" htmlFor="user_site">Site</label>
        <select className="form-control is-valid select optional" name="user[site]" id="user_site">
          <option value=""></option>
          { this.state.sites.map(site => <option key={site.id} value={site.id}>{site.name}</option>) }
        </select>
      </>
    )
  }
}

export default Site