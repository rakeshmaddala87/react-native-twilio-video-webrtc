import React, { Component } from 'react'
import { requireNativeComponent } from 'react-native'

class TwilioBroadcastButton extends Component {
  render () {
    return (
      <RCTTwilioBroadcastButton {...this.props} />
    )
  }
}

const RCTTwilioBroadcastButton = requireNativeComponent(
  'RCTBroadcastPickerView',
  TwilioBroadcastButton
)

module.exports = TwilioBroadcastButton
