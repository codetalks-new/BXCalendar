//
//  UINavigationControllerExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/30.
//
//

import Foundation

import UIKit

public extension UINavigationController{
  public func bx_replaceTopViewController(with viewController:UIViewController){
    var  vcArray = viewControllers
    vcArray.popLast()
    vcArray.append(viewController)
    setViewControllers(vcArray, animated: true)
  }
  
  public func bx_popTwoViewController(_ animated:Bool = true){
    var  vcArray = viewControllers
    vcArray.popLast()
    vcArray.popLast()
    setViewControllers(vcArray, animated: animated)
  }
}
