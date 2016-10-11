//
//  UIViewController+Alert.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/31.
//
//

import UIKit

public extension UIViewController{
  public func bx_prompt(_ message:String,handler:@escaping ((Bool) -> Void)){
    let confirmController = ConfirmAlertController(title: nil, message: message, preferredStyle: .alert)
    confirmController.onConfirmCallback = {
      sure in
      handler(sure)
    }
    present(confirmController, animated: true, completion: nil)
  }
  
  public func bx_confirm(_ message:String,closure:@escaping ( (Void) -> Void)){
    let confirmController = ConfirmAlertController(title: nil, message: message, preferredStyle: .alert)
    confirmController.shouldShowCancelButton = false
    confirmController.onConfirmCallback = {
      sure in
      closure()
    }
    present(confirmController, animated: true, completion: nil)
  }
}
