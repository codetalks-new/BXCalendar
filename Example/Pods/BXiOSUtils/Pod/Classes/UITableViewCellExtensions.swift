//
//  UITableViewCellExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit

public extension UITableViewCell{
  public func bx_removeSeperatorInset(){
    separatorInset = UIEdgeInsets.zero
    bx_removeLayoutMargins()
  }
  
  public func bx_removeSeparator(){
      separatorInset = UIEdgeInsets(top: 0, left: 3600, bottom: 0, right: 0)
  }
  
  public func bx_removeLayoutMargins(){
      preservesSuperviewLayoutMargins = false
      layoutMargins = UIEdgeInsets.zero
  }
}
