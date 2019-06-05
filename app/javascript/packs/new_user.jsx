
// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import Avatar from "avataaars";

const SelectAvatar = props => (
    <Avatar
    avatarStyle='Circle'
    topType='LongHairStraight'
    accessoriesType='Blank'
    hairColor='BrownDark'
    facialHairType='Blank'
    clotheType='BlazerShirt'
    eyeType='Default'
    eyebrowType='Default'
    mouthType='Default'
    skinColor='Light'
  />
  
)

// Hello.defaultProps = {
//   name: 'David'
// }

// Hello.propTypes = {
//   name: PropTypes.string
// }

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <SelectAvatar name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
