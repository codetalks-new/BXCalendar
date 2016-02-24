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

public class BXCalendarDatePickerController : BXCalendarViewController {
  
  
  public override init(){
    super.init()
    transitioningDelegate = self
    modalPresentationStyle = .Custom
    modalTransitionStyle = .CrossDissolve
    preferredContentSize = CGSize(width: screenWidth, height: 390)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  
  
  override public func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
}

extension BXCalendarDatePickerController:UIViewControllerTransitioningDelegate{
  public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
    let presentation = AlertPresentationController(presentedViewController: presented, presentingViewController: presenting)
    return presentation
  }
}