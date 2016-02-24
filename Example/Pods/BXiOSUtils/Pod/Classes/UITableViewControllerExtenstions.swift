//
//  UITableViewControllerExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit
public extension UITableViewController{
  public func bx_isLastSection(section:Int) -> Bool{
    return (section + 1) == tableView.numberOfSections
  }
  
  public func bx_isLastRowInSection(indexPath:NSIndexPath) -> Bool{
    let rows = tableView.numberOfRowsInSection(indexPath.section)
    return indexPath.row == (rows - 1)
  }
  
  public func bx_isLastRow(indexPath:NSIndexPath) -> Bool{
    return bx_isLastSection(indexPath.section) && bx_isLastRowInSection(indexPath)
  }
  
  public func bx_lastIndexPath() -> NSIndexPath{
    let section = tableView.numberOfSections - 1
    let row = tableView.numberOfRowsInSection(section) - 1
    return NSIndexPath(forRow: row, inSection: section)
  }
  public func bx_isFirstRow(indexPath:NSIndexPath) ->Bool{
    return indexPath.section == 0 && indexPath.row == 0
  }
  
  public func bx_firstIndexPath() -> NSIndexPath{
    return NSIndexPath(forRow: 0, inSection: 0)
  }
}