//
//  BXActionSheetPresentationController.swift
//  VV3CV4
//
//  Created by Haizhen Lee on 15/12/20.
//  Copyright © 2015年 vv3c. All rights reserved.
//

import UIKit


open class ActionSheetPresentationController:UIPresentationController{
  lazy var dimmingView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    view.alpha  = 0.0
    view.isUserInteractionEnabled = true
    view.tag = 1024
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSheetPresentationController.dismiss)))
    return view
  }()
  
  func dismiss(){
    presentedViewController.dismiss(animated: true, completion: nil)
  }
  
  open override var frameOfPresentedViewInContainerView : CGRect {
    let bounds = containerView!.bounds
    
    return bounds.divided(atDistance: presentedViewController.preferredContentSize.height, from: CGRectEdge.maxYEdge).slice
  }
  
  open override func presentationTransitionWillBegin() {
    let containerView = self.containerView!
    let presentedVC = self.presentedViewController
//    let _ = self.presentingViewController
    // Set the dimming view to the size of the container's bounds, and make it transparent initialy
    dimmingView.frame = containerView.bounds
    dimmingView.alpha = 0.0
    // Insert the dimming view below everything
    containerView.insertSubview(dimmingView, at: 0)
    
    // Set up the animations for fading in the dimming view.
    if let coordinator = presentedVC.transitionCoordinator{
      coordinator.animate(alongsideTransition: { (ctx) -> Void in
        // Fade ind
        self.dimmingView.alpha = 1.0
        }, completion: { (ctx) -> Void in
          
      })
    }else{
      self.dimmingView.alpha = 0.0
    }
    
  }
  
  open override func presentationTransitionDidEnd(_ completed: Bool) {
    // If the presentation was canceld, remove the dimming view.
    if !completed{
      self.dimmingView.removeFromSuperview()
    }
  }
  
  open override func dismissalTransitionWillBegin() {
    // Fade the dimming view back out
    if let coordinator = presentedViewController.transitionCoordinator{
      coordinator.animate(alongsideTransition: { (ctx) -> Void in
        self.dimmingView.alpha = 0.0
        }, completion: nil)
      
    }else{
      self.dimmingView.alpha = 1.0
    }
  }
  
  open override func dismissalTransitionDidEnd(_ completed: Bool) {
    // If the dismissal was successful, remove the dimming view
    if completed{
      self.dimmingView.removeFromSuperview()
    }
  }
}
