//
//  StaticTableViewDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/1.
//
//

import Foundation

public class StaticTableViewDataSource:NSObject,UITableViewDataSource,BXDataSourceContainer{
  public private(set) var cells:[UITableViewCell] = []
  public typealias ItemType = UITableViewCell
  public var section = 0
  public init(cells:[UITableViewCell] = []){
    self.cells = cells
  }
  
  
  
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  public func cellAtIndexPath(indexPath:NSIndexPath) -> UITableViewCell{
    return self.cells[indexPath.row]
  }
 
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cells.count
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    return cells[indexPath.row]
  }
  
  public func append(cell:UITableViewCell){
    if !cells.contains(cell){
      self.cells.append(cell)
    }
  }
  
  public func appendContentsOf(cells:[UITableViewCell]){
    for cell in cells{
        append(cell)
    }
  }
 
  
  public func updateItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
   self.cells.removeAll()
    self.cells.appendContentsOf(items)
  }
  
  public func appendItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    self.cells.appendContentsOf(items)
  }
  public var numberOfItems:Int{ return cells.count }
  
}