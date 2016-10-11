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

open class StaticTableViewAdapter:StaticTableViewDataSource,UITableViewDelegate{
  open var referenceSectionHeaderHeight:CGFloat = 15
  open var referenceSectionFooterHeight:CGFloat = 15
  open var sectionHeaderView:UIView?
  open var sectionFooterView:UIView?
  open fileprivate(set) weak var tableView:UITableView?
  
  open var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }
  
  open var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }
  
  open var didSelectCell:((UITableViewCell,IndexPath) -> Void)?
  
 public override init(cells: [UITableViewCell] = []) {
   super.init(cells: cells)
  }
  
  open func bindTo(_ tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  // MARK:UITableViewDelegate
   open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellAtIndexPath(indexPath).bx_height
  }
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = cellAtIndexPath(indexPath)
    self.didSelectCell?(cell,indexPath)
    cell.setSelected(false, animated: true)
  }
  
  open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    return sectionHeaderHeight
  }
  
  open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    return sectionFooterHeight
  }
  
  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    return sectionHeaderView
  }
  
  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return sectionFooterView
  }
 
  open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    let cell = cellAtIndexPath(indexPath)
    return cell.bx_shouldHighlight
  }
  
}
