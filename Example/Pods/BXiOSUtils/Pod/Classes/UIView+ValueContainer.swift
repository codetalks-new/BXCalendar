//
//  UIView+ValueContainer.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/19.
//
//

import UIKit

public extension UIView{
   struct BXAssociatedKeys{
    static var bx_value = "bx_value"
  }
  
  public var bx_value:String?{
    set{
      objc_setAssociatedObject(self, &BXAssociatedKeys.bx_value, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }get{
      let value = objc_getAssociatedObject(self, &BXAssociatedKeys.bx_value)
      return value as? String
    }
  }
}
