//
//  BXActionSheetPresentationController.swift
//  VV3CV4
//
//  Created by Haizhen Lee on 15/12/20.
//  Copyright © 2015年 vv3c. All rights reserved.
//

import UIKit


public class ActionSheetPresentationController:UIPresentationController{
  lazy var dimmingView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    view.alpha  = 0.0
    view.userInteractionEnabled = true
    view.tag = 1024
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSheetPresentationController.dismiss)))
    return view
  }()
  
  func dismiss(){
    presentedViewController.dismissViewControllerAnimated(true, completion: nil)
  }
  
  public override func frameOfPresentedViewInContainerView() -> CGRect {
    let bounds = containerView!.bounds
    
    return bounds.divide(presentedViewController.preferredContentSize.height, fromEdge: CGRectEdge.MaxYEdge).slice
  }
  
  public override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    
  }
  
  public override func presentationTransitionWillBegin() {
    let containerView = self.containerView!
    let presentedVC = self.presentedViewController
//    let _ = self.presentingViewController
    // Set the dimming view to the size of the container's bounds, and make it transparent initialy
    dimmingView.frame = containerView.bounds
    dimmingView.alpha = 0.0
    // Insert the dimming view below everything
    containerView.insertSubview(dimmingView, atIndex: 0)
    
    // Set up the animations for fading in the dimming view.
    if let coordinator = presentedVC.transitionCoordinator(){
      coordinator.animateAlongsideTransition({ (ctx) -> Void in
        // Fade ind
        self.dimmingView.alpha = 1.0
        }, completion: { (ctx) -> Void in
          
      })
    }else{
      self.dimmingView.alpha = 0.0
    }
    
  }
  
  public override func presentationTransitionDidEnd(completed: Bool) {
    // If the presentation was canceld, remove the dimming view.
    if !completed{
      self.dimmingView.removeFromSuperview()
    }
  }
  
  public override func dismissalTransitionWillBegin() {
    // Fade the dimming view back out
    if let coordinator = presentedViewController.transitionCoordinator(){
      coordinator.animateAlongsideTransition({ (ctx) -> Void in
        self.dimmingView.alpha = 0.0
        }, completion: nil)
      
    }else{
      self.dimmingView.alpha = 1.0
    }
  }
  
  public override func dismissalTransitionDidEnd(completed: Bool) {
    // If the dismissal was successful, remove the dimming view
    if completed{
      self.dimmingView.removeFromSuperview()
    }
  }
}