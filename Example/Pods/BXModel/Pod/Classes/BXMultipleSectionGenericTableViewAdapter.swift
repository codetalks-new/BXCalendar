//
//  BXMultipleSectionGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation

public class BXMultipleSectionGenericTableViewAdapter<Key:Hashable,T:BXModelAware,V:UITableViewCell where V:BXBindable, Key:StringInterpolationConvertible>: BXMutipleSectionGenericDataSource<Key,T>,UITableViewDelegate{
  public private(set) var tableView:UITableView?
  public var didSelectedItem: DidSelectedItemBlock?
  public var configureCellBlock:( (V,NSIndexPath) -> Void )?
  public init(tableView:UITableView? = nil,dict:Dictionary<Key,[T]> = [:]){
    super.init(dict: dict)
    if let tableView = tableView{
      bindTo(tableView)
    }
  }
  
  public func bindTo(tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
    self.reuseIdentifier = simpleClassName(V)+"_cell"
    if V.hasNib{
      tableView.registerNib(V.nib(), forCellReuseIdentifier: reuseIdentifier)
    }else{
      tableView.registerClass(V.self, forCellReuseIdentifier: reuseIdentifier)
    }
  }
  
 
  //MARK: TableViewDelegate
  

  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.didSelectedItem?(itemAtIndexPath(indexPath),atIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  // DataSource Override
  
  public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return cellForRowAtIndexPath(indexPath)
  }
  
  public func cellForRowAtIndexPath(indexPath:NSIndexPath) -> V {
    let cell = tableView!.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! V
    let model = itemAtIndexPath(indexPath)
    if let m = model as? V.ModelType{
      cell.bind(m)
    }
    configureCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  public func configureCell(cell:V,atIndexPath indexPath:NSIndexPath){
    self.configureCellBlock?(cell,indexPath)
  }
  
  public override func updateDict(dict: [Key:[T]]) {
    super.updateDict(dict)
    tableView?.reloadData()
  }
//
//  public override func appendItems(items: [T]) {
//    super.appendItems(items)
//    tableView.reloadData()
//  }
  
}