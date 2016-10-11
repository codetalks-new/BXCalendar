//
//  BXCalendarDatePickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/25.
//
//

import UIKit
import BXForm
import BXiOSUtils

open class BXCalendarDatePickerController : BXCalendarViewController {
  
  
  public override init(){
    super.init()
    transitioningDelegate = self
    modalPresentationStyle = .custom
    modalTransitionStyle = .crossDissolve
    preferredContentSize = CGSize(width: screenWidth, height: 390)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  
  
  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
}

extension BXCalendarDatePickerController:UIViewControllerTransitioningDelegate{
  public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentation = AlertPresentationController(presentedViewController: presented, presenting: presenting)
    return presentation
  }
}
