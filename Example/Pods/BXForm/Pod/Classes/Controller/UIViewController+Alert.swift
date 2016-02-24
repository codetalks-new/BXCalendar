//
//  UIViewController+Alert.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/31.
//
//

import UIKit

public extension UIViewController{
  public func bx_prompt(message:String,handler:(Bool -> Void)){
    let confirmController = ConfirmAlertController(title: nil, message: message, preferredStyle: .Alert)
    confirmController.onConfirmCallback = {
      sure in
      handler(sure)
    }
    presentViewController(confirmController, animated: true, completion: nil)
  }
  
  public func bx_confirm(message:String,closure:( Void -> Void)){
    let confirmController = ConfirmAlertController(title: nil, message: message, preferredStyle: .Alert)
    confirmController.shouldShowCancelButton = false
    confirmController.onConfirmCallback = {
      sure in
      closure()
    }
    presentViewController(confirmController, animated: true, completion: nil)
  }
}