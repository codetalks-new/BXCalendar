//
//  UIApplicationExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension UIApplication{
  public var  isActive:Bool{
    return applicationState == .Active
  }
  
  public var isInactive:Bool{
    return applicationState == .Inactive
  }
  
  public var isBackground:Bool{
    return applicationState == .Background
  }
  
  public var rootViewController:UIViewController?{
    return keyWindow?.rootViewController
  }
  
}
