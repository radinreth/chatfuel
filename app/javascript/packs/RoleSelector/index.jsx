import React from 'react'
import axios from 'axios'
import NoSite from './NoSite'
import Site from './Site'

class RoleSelector extends React.Component {
  constructor(props) {
    super(props)
    this.onRoleSelected = this.onRoleSelected.bind(this)
    this.state = { roles: [], selectedRole: null }
  }

  onRoleSelected(event) {
    this.setState({selectedRole: event.target.value})
  }

  getRoles() {
    axios.get("/role/users.json")
      .then( response => this.setState({ roles: response.data }))
      .catch( error => console.log(error) )
  }

  componentDidMount() {
    this.getRoles()
  }

  render() {
    let SiteComponent = NoSite;
    let { roles, selectedRole } = this.state;

    if( ['site_admin', 'system_admin'].indexOf(selectedRole) >= 0 ) {
      SiteComponent = Site
    }

    return (
      <>
        <label className="select optional" htmlFor="user_role">Role</label>
        <select onChange={this.onRoleSelected} className="form-control is-valid select optional" name="user[role]" id="user_role">
          <option value=""></option>
          {
            Object.keys(roles).map((role, index) => <option key={index} value={role}>{ role }</option>)
          }
        </select>

        <SiteComponent />
      </>
    )
  }
}

export default RoleSelector