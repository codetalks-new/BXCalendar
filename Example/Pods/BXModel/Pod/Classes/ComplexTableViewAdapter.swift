//
//  ComplexTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/3.
//
//

import Foundation
import UIKit

public class ComplexTableViewAdapter<T,V:StaticTableViewCell where V:BXBindable >:SimpleGenericTableViewAdapter<T,V>{
 
  var cells:[UITableViewCell] = []
  public init(
    tableView:UITableView? = nil,items:[T] = [],
    cells:[UITableViewCell] = []){
      super.init(tableView: tableView, items: items)
    self.cells = cells
  }
  
  public func cellAtIndexPath(indexPath:NSIndexPath) -> UITableViewCell{
    return self.cells[indexPath.row]
  }
  
  public override func itemAtIndexPath(indexPath: NSIndexPath) -> T {
    let index = indexPath.row - cells.count
    return items[index]
  }
  
  public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows()
  }
  
  public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    if indexPath.row < cells.count{
      return cellAtIndexPath(indexPath)
    }else{
      return super.cellForRowAtIndexPath(indexPath)
    }
  }
  
  public func append(cell:UITableViewCell){
    self.cells.append(cell)
    tableView?.reloadData()
  }
  
  public func appendContentsOf(cells:[UITableViewCell]){
    self.cells.appendContentsOf(cells)
    tableView?.reloadData()
  }
  
  public override func numberOfRows() -> Int {
    return cells.count + super.numberOfItems
  }
  
  public override var numberOfItems:Int{
    return cells.count + super.numberOfItems
  }
}