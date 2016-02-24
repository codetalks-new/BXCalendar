//
//  StaticTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/1.
//
//

import Foundation

public protocol StaticTableViewCellAware{
  var bx_height:CGFloat{ get }
  var bx_shouldHighlight:Bool{ get }
}

extension UITableViewCell:StaticTableViewCellAware{
  public var bx_height:CGFloat{ return 44 }
  public var bx_shouldHighlight:Bool{ return true }
}

public class StaticTableViewAdapter:StaticTableViewDataSource,UITableViewDelegate{
  public var referenceSectionHeaderHeight:CGFloat = 15
  public var referenceSectionFooterHeight:CGFloat = 15
  public var sectionHeaderView:UIView?
  public var sectionFooterView:UIView?
  public private(set) weak var tableView:UITableView?
  
  public var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }
  
  public var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }
  
  public var didSelectCell:((UITableViewCell,NSIndexPath) -> Void)?
  
 public override init(cells: [UITableViewCell] = []) {
   super.init(cells: cells)
  }
  
  public func bindTo(tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  // MARK:UITableViewDelegate
   public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
    return cellAtIndexPath(indexPath).bx_height
  }
  
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = cellAtIndexPath(indexPath)
    self.didSelectCell?(cell,indexPath)
    cell.setSelected(false, animated: true)
  }
  
  public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    return sectionHeaderHeight
  }
  
  public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return sectionFooterHeight
  }
  
  public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    return sectionHeaderView
  }
  
  public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return sectionFooterView
  }
 
  public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    let cell = cellAtIndexPath(indexPath)
    return cell.bx_shouldHighlight
  }
  
}