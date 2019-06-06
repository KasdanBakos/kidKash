// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Button from "@material-ui/core/Button";

const AccountCard2 = (
  <div>
    Hi
  </div>
)

AccountCard2.propTypes = {
  account_type: PropTypes.string, // checking or savings
  balance: PropTypes.string,
  is_child: PropTypes.bool
}

document.addEventListener('DOMContentLoaded', props => {

  ReactDOM.render(
    <AccountCard2 />,
    document.body.appendChild(document.createElement('div')),
  )
})
