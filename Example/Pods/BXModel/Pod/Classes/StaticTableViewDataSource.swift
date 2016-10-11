//
//  StaticTableViewDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/1.
//
//

import Foundation

open class StaticTableViewDataSource:NSObject,UITableViewDataSource,BXDataSourceContainer{
  open fileprivate(set) var cells:[UITableViewCell] = []
  public typealias ItemType = UITableViewCell
  open var section = 0
  
  open var configureCellBlock:((UITableViewCell) -> Void)?
  
  public init(cells:[UITableViewCell] = []){
    self.cells = cells
  }
  
  
  
  open func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  open func cellAtIndexPath(_ indexPath:IndexPath) -> UITableViewCell{
    return self.cells[(indexPath as NSIndexPath).row]
  }
 
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cells.count
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = cellAtIndexPath(indexPath)
    self.configureCellBlock?(cell)
    return cell
  }
  
  open func append(_ cell:UITableViewCell){
    if !cells.contains(cell){
      self.cells.append(cell)
    }
  }
  
  open func appendContentsOf(_ cells:[UITableViewCell]){
    for cell in cells{
        append(cell)
    }
  }
 
  
  open func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
   self.cells.removeAll()
    self.cells.append(contentsOf: items)
  }
  
  open func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    self.cells.append(contentsOf: items)
  }
  open var numberOfItems:Int{ return cells.count }
  
}
