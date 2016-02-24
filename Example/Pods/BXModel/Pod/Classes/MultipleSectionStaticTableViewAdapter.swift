//
//  MultipleSectionTableViewDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/31.
//
//

import UIKit

public class StaticTableViewSection {
  public var referenceSectionHeaderHeight:CGFloat = 44
  public var referenceSectionFooterHeight:CGFloat = 44
  public var sectionHeaderView:UIView?
  public var sectionFooterView:UIView?
  public private(set) var cells:[UITableViewCell] = []
  
  public init(cells:[UITableViewCell] = []){
    self.cells = cells
  }
  
  public func updateCells(cells:[UITableViewCell]){
    self.cells = cells
  }
  
  public var numberOfRows:Int{
    return cells.count
  }
  
  public var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }
  
  public var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }
}

public class MultipleSectionStaticTableViewAdapter:NSObject,UITableViewDataSource,BXDataSourceContainer,UITableViewDelegate{
  public private(set) var tableViewSections:[StaticTableViewSection] = []
  public typealias ItemType = StaticTableViewSection
  
  public var didSelectCell:((UITableViewCell,NSIndexPath) -> Void)?
  public private(set) weak var tableView:UITableView?
  
  public init(sections:[StaticTableViewSection] = []){
    self.tableViewSections = sections
  }
  
  public func bindTo(tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
  }
  

  private func tableViewSectionAt(section:Int) -> StaticTableViewSection{
    return tableViewSections[section]
  }
  
  public func cellAtIndexPath(indexPath:NSIndexPath) -> UITableViewCell{
    return self.tableViewSectionAt(indexPath.section).cells[indexPath.row]
  }
  
  // MARK: UITableViewDataSource
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tableViewSections.count
  }
  
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableViewSectionAt(section).numberOfRows
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    return cellAtIndexPath(indexPath)
  }
  
  // MARK: UITableViewDelegate
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = cellAtIndexPath(indexPath)
    self.didSelectCell?(cell,indexPath)
  }
 
  public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellAtIndexPath(indexPath).bx_height
  }

  public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
      return tableViewSectionAt(section).sectionHeaderHeight
  }
  
  public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
      return tableViewSectionAt(section).sectionFooterHeight
  }
  
  public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{ // custom view for header. will be adjusted to default or specified header height
    return tableViewSectionAt(section).sectionHeaderView
  }
  
  public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{ // custom view for footer. will be adjusted to default or specified footer height
    return tableViewSectionAt(section).sectionFooterView
  }
  
  
  // MARK: DataSource Container
  public func append(section:StaticTableViewSection){
    self.tableViewSections.append(section)
    self.tableView?.reloadData()
  }
  
  public func appendContentsOf(sections:[StaticTableViewSection]){
    self.tableViewSections.appendContentsOf(sections)
    self.tableView?.reloadData()
  }
  
  
  public func updateItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    self.tableViewSections.removeAll()
    self.tableViewSections.appendContentsOf(items)
    self.tableView?.reloadData()
  }
  
  public func appendItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    self.tableViewSections.appendContentsOf(items)
    self.tableView?.reloadData()
  }
  public var numberOfItems:Int{ return tableViewSections.count }
  
}