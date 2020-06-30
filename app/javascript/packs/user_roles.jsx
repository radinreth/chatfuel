import React from "react"
import ReactDOM from "react-dom"
import RoleSelector from "./RoleSelector"

document.addEventListener('turbolinks:load', () => {
  var roleComponent = document.getElementById("role-component");
  ReactDOM.render(<RoleSelector />, roleComponent);
})
