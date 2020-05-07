//
//  RCTBroadcastPicker.swift
//  RNTwilioVideoWebRTC
//
//  Created by Subhajeet Sarkar on 4/14/20.
//  Copyright © 2020 Employ. All rights reserved.
//

import UIKit
import ReplayKit
import TwilioVideo

class BroadcastPicker: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // in here you can configure your view
    private func setupView() {
        self.isUserInteractionEnabled = true
        // Use RPSystemBroadcastPickerView when available (iOS 12+ devices).
        if #available(iOS 12.0, *) {
            setupPickerView()
        }
    }
    
    @objc(setExtId:)
    func setExtId(extId: String) {
        #if !targetEnvironment(simulator)
        if #available(iOS 12.0, *) {
            let pickerView = self.subviews[0] as! RPSystemBroadcastPickerView
            pickerView.preferredExtension = extId;
        }
        #endif
    }
    
    @available(iOS 12.0, *)
    func setupPickerView() {
        #if !targetEnvironment(simulator)
        // iOS 13.0 throws an NSInvalidArgumentException when RPSystemBroadcastPickerView is used to start a broadcast.
        // https://stackoverflow.com/questions/57163212/get-nsinvalidargumentexception-when-trying-to-present-rpsystembroadcastpickervie
        if #available(iOS 13.0, *) {
            // The issue is resolved in iOS 13.1.
            if #available(iOS 13.1, *) {
            } else {
                 //show alert that broadcast is not available of 13.0.*
                return
            }
        }
        
        // SJ: setup the picker view to select the broadcast service
        let pickerView = RPSystemBroadcastPickerView(frame: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: 50,
                                                                   height: 50))
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.showsMicrophoneButton = false
        
        // Theme the picker view to match the white that we want.
        if let button = pickerView.subviews.first as? UIButton {
            if(button.imageView != nil){
                button.setImage(nil, for: .normal)
            }
        }
        
        self.addSubview(pickerView)
        
        let centerX = NSLayoutConstraint(item:pickerView,
                                         attribute: NSLayoutConstraint.Attribute.centerX,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.centerX,
                                         multiplier: 1,
                                         constant: 0);
        self.addConstraint(centerX)
        let centerY = NSLayoutConstraint(item: pickerView,
                                         attribute: NSLayoutConstraint.Attribute.centerY,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.centerY,
                                         multiplier: 1,
                                         constant: 0);
        self.addConstraint(centerY)
        let width = NSLayoutConstraint(item: pickerView,
                                       attribute: NSLayoutConstraint.Attribute.width,
                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                       toItem: self,
                                       attribute: NSLayoutConstraint.Attribute.width,
                                       multiplier: 1,
                                       constant: 0);
        self.addConstraint(width)
        let height = NSLayoutConstraint(item: pickerView,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: self,
                                        attribute: NSLayoutConstraint.Attribute.height,
                                        multiplier: 1,
                                        constant: 0);
        self.addConstraint(height)
        #endif
    }

}
    
@objc (RCTBroadcastPickerViewManager)
class RCTBroadcastPickerViewManager: RCTViewManager {
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    override func view() -> UIView! {
        return BroadcastPicker()
    }
}
