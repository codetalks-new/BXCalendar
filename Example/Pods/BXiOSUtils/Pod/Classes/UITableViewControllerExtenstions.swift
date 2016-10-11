//
//  UITableViewControllerExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit
public extension UITableViewController{
  public func bx_isLastSection(_ section:Int) -> Bool{
    return (section + 1) == tableView.numberOfSections
  }
  
  public func bx_isLastRowInSection(_ indexPath:IndexPath) -> Bool{
    let rows = tableView.numberOfRows(inSection: (indexPath as NSIndexPath).section)
    return (indexPath as NSIndexPath).row == (rows - 1)
  }
  
  public func bx_isLastRow(_ indexPath:IndexPath) -> Bool{
    return bx_isLastSection((indexPath as NSIndexPath).section) && bx_isLastRowInSection(indexPath)
  }
  
  public func bx_lastIndexPath() -> IndexPath{
    let section = tableView.numberOfSections - 1
    let row = tableView.numberOfRows(inSection: section) - 1
    return IndexPath(row: row, section: section)
  }
  public func bx_isFirstRow(_ indexPath:IndexPath) ->Bool{
    return (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0
  }
  
  public func bx_firstIndexPath() -> IndexPath{
    return IndexPath(row: 0, section: 0)
  }
}
