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
    return applicationState == .active
  }
  
  public var isInactive:Bool{
    return applicationState == .inactive
  }
  
  public var isBackground:Bool{
    return applicationState == .background
  }
  
  public var rootViewController:UIViewController?{
    return keyWindow?.rootViewController
  }
  
}
