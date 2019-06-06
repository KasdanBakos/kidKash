// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Button from "@material-ui/core/Button";

const AccountCard = props => (
  <div>
    Hi {props.account_type} Account
    <br />
    {props.balance}
    <br />
    {!props.is_child && 'hi'}
  </div>
)

AccountCard.propTypes = {
  account_type: PropTypes.string, // checking or savings
  balance: PropTypes.string,
  is_child: PropTypes.bool
}

document.addEventListener('DOMContentLoaded', props => {
  const node = document.getElementById('appointments_data')
  const data = JSON.parse(node.getAttribute('data'))

  ReactDOM.render(
    <AccountCard account_type={data.account_type} balance={data.balance} is_child={data.is_child} />,
    document.body.appendChild(document.createElement('div')),
  )
})
