//
//  MultipleSectionTableViewDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/31.
//
//

import UIKit

open class StaticTableViewSection {
  open var referenceSectionHeaderHeight:CGFloat = 44
  open var referenceSectionFooterHeight:CGFloat = 44
  open var sectionHeaderView:UIView?
  open var sectionFooterView:UIView?
  open fileprivate(set) var cells:[UITableViewCell] = []
  
  public init(cells:[UITableViewCell] = []){
    self.cells = cells
  }
  
  open func updateCells(_ cells:[UITableViewCell]){
    self.cells = cells
  }
  
  open var numberOfRows:Int{
    return cells.count
  }
  
  open var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }
  
  open var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }
}

open class MultipleSectionStaticTableViewAdapter:NSObject,UITableViewDataSource,BXDataSourceContainer,UITableViewDelegate{
  open fileprivate(set) var tableViewSections:[StaticTableViewSection] = []
  public typealias ItemType = StaticTableViewSection
  
  open var didSelectCell:((UITableViewCell,IndexPath) -> Void)?
  open fileprivate(set) weak var tableView:UITableView?
  
  public init(sections:[StaticTableViewSection] = []){
    self.tableViewSections = sections
  }
  
  open func bindTo(_ tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
  }
  

  fileprivate func tableViewSectionAt(_ section:Int) -> StaticTableViewSection{
    return tableViewSections[section]
  }
  
  open func cellAtIndexPath(_ indexPath:IndexPath) -> UITableViewCell{
    return self.tableViewSectionAt((indexPath as NSIndexPath).section).cells[(indexPath as NSIndexPath).row]
  }
  
  // MARK: UITableViewDataSource
  open func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewSections.count
  }
  
  
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableViewSectionAt(section).numberOfRows
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    return cellAtIndexPath(indexPath)
  }
  
  // MARK: UITableViewDelegate
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = cellAtIndexPath(indexPath)
    self.didSelectCell?(cell,indexPath)
  }
 
  open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellAtIndexPath(indexPath).bx_height
  }

  open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return tableViewSectionAt(section).sectionHeaderHeight
  }
  
  open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
      return tableViewSectionAt(section).sectionFooterHeight
  }
  
  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    return tableViewSectionAt(section).sectionHeaderView
  }
  
  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return tableViewSectionAt(section).sectionFooterView
  }
  
  
  // MARK: DataSource Container
  open func append(_ section:StaticTableViewSection){
    self.tableViewSections.append(section)
    self.tableView?.reloadData()
  }
  
  open func appendContentsOf(_ sections:[StaticTableViewSection]){
    self.tableViewSections.append(contentsOf: sections)
    self.tableView?.reloadData()
  }
  
  
  open func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    self.tableViewSections.removeAll()
    self.tableViewSections.append(contentsOf: items)
    self.tableView?.reloadData()
  }
  
  open func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    self.tableViewSections.append(contentsOf: items)
    self.tableView?.reloadData()
  }
  open var numberOfItems:Int{ return tableViewSections.count }
  
}
