//
//  BXMultipleSectionGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation

open class BXMultipleSectionGenericTableViewAdapter<Key:Hashable,T:BXModelAware,V:UITableViewCell>: BXMutipleSectionGenericDataSource<Key,T>,UITableViewDelegate where V:BXBindable{
  open fileprivate(set) var tableView:UITableView?
  open var didSelectedItem: DidSelectedItemBlock?
  open var configureCellBlock:( (V,IndexPath) -> Void )?
  public init(tableView:UITableView? = nil,dict:Dictionary<Key,[T]> = [:]){
    super.init(dict: dict)
    if let tableView = tableView{
      bindTo(tableView)
    }
  }
  
  open func bindTo(_ tableView:UITableView){
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
    self.reuseIdentifier = simpleClassName(V.self)+"_cell"
    if V.hasNib{
      tableView.register(V.nib(), forCellReuseIdentifier: reuseIdentifier)
    }else{
      tableView.register(V.self, forCellReuseIdentifier: reuseIdentifier)
    }
  }
  
 
  //MARK: TableViewDelegate
  

  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectedItem?(itemAtIndexPath(indexPath),indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // DataSource Override
  
  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellForRowAtIndexPath(indexPath)
  }
  
  open func cellForRowAtIndexPath(_ indexPath:IndexPath) -> V {
    let cell = tableView!.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! V
    let model = itemAtIndexPath(indexPath)
    if let m = model as? V.ModelType{
      cell.bind(m)
    }
    configureCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  open func configureCell(_ cell:V,atIndexPath indexPath:IndexPath){
    self.configureCellBlock?(cell,indexPath)
  }
  
  open override func updateDict(_ dict: [Key:[T]]) {
    super.updateDict(dict)
    tableView?.reloadData()
  }
//
//  public override func appendItems(items: [T]) {
//    super.appendItems(items)
//    tableView.reloadData()
//  }
  
}
