//
//  ComplexTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/3.
//
//

import Foundation
import UIKit

open class ComplexTableViewAdapter<T,V:StaticTableViewCell>:SimpleGenericTableViewAdapter<T,V> where V:BXBindable {
 
  var cells:[UITableViewCell] = []
  public init(
    tableView:UITableView? = nil,items:[T] = [],
    cells:[UITableViewCell] = []){
      super.init(tableView: tableView, items: items)
    self.cells = cells
  }
  
  open func cellAtIndexPath(_ indexPath:IndexPath) -> UITableViewCell{
    return self.cells[(indexPath as NSIndexPath).row]
  }
  
  open override func itemAtIndexPath(_ indexPath: IndexPath) -> T {
    let index = (indexPath as NSIndexPath).row - cells.count
    return items[index]
  }
  
  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows()
  }
  
  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    if (indexPath as NSIndexPath).row < cells.count{
      return cellAtIndexPath(indexPath)
    }else{
      return super.cellForRowAtIndexPath(indexPath)
    }
  }
  
  open func append(_ cell:UITableViewCell){
    self.cells.append(cell)
    tableView?.reloadData()
  }
  
  open func appendContentsOf(_ cells:[UITableViewCell]){
    self.cells.append(contentsOf: cells)
    tableView?.reloadData()
  }
  
  open override func numberOfRows() -> Int {
    return cells.count + super.numberOfItems
  }
  
  open override var numberOfItems:Int{
    return cells.count + super.numberOfItems
  }
}
