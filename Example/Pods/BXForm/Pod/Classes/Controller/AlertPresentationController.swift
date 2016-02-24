//
//  AlertPresentationController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/27.
//
//

import Foundation
import UIKit


public class AlertPresentationController:UIPresentationController{
  lazy var dimmingView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    view.alpha  = 0.0
    return view
  }()
  
  public override func frameOfPresentedViewInContainerView() -> CGRect {
    let bounds = containerView!.bounds
    let preferedSize = presentedViewController.preferredContentSize
    return CGRect(center: bounds.center, size:preferedSize)
  }
  
  public override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    
  }
  
  public override func presentationTransitionWillBegin() {
    let containerView = self.containerView!
    let presentedVC = self.presentedViewController
//    let presentingVC = self.presentingViewController
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