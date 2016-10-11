//
//  SimpleGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit

open class SimpleGenericTableViewAdapter<T,V:UITableViewCell>: SimpleGenericDataSource<T>,UITableViewDelegate where V:BXBindable {
  open fileprivate(set) weak var tableView:UITableView?
  open var didSelectedItem: DidSelectedItemBlock?
  open var preBindCellBlock:( (V,IndexPath) -> Void )?
  open var postBindCellBlock:( (V,IndexPath) -> Void )?
  open var configureCellBlock:( (V,IndexPath) -> Void )?
  public typealias WillDisplayCellBlock = ( (V,_ withItem:T,_ atIndexPath:IndexPath) -> Void )
  open var willDisplayCellBlock: WillDisplayCellBlock?
  
  open var allowSelection = false
  
  open var referenceSectionHeaderHeight:CGFloat = 15
  open var referenceSectionFooterHeight:CGFloat = 15
  open var sectionHeaderView:UIView?
  open var sectionFooterView:UIView?
  open var sectionHeaderHeight:CGFloat{
    return sectionHeaderView == nil ? 0:referenceSectionHeaderHeight
  }
  
  open var sectionFooterHeight:CGFloat{
    return sectionFooterView == nil ? 0:referenceSectionFooterHeight
  }
  
  public init(tableView:UITableView? = nil,items:[T] = []){
    super.init(items: items)
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
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectedItem?(itemAtIndexPath(indexPath),indexPath)
    if !allowSelection{
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellForRowAtIndexPath(indexPath)
  }
  
  open func cellForRowAtIndexPath(_ indexPath:IndexPath) -> V {
    let cell = tableView!.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! V
    let model = itemAtIndexPath(indexPath)
    preBindCellBlock?(cell,indexPath)
    if let m = model as? V.ModelType{
      cell.bind(m)
    }
    configureCell(cell, atIndexPath: indexPath)
    postBindCellBlock?(cell,indexPath)
    return cell
  }
  
  open func configureCell(_ cell:V,atIndexPath indexPath:IndexPath){
    self.configureCellBlock?(cell,indexPath)
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
  
  //MARK: UITableViewDelegate
  open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let item = itemAtIndexPath(indexPath)
    if let subCell = cell as? V{
      self.willDisplayCellBlock?(subCell,item,indexPath)
    }
  }
  
  
  open override func updateItems<S:Sequence>(_ items: S) where S.Iterator.Element == T {
    super.updateItems(items)
    tableView?.reloadData()
  }
  
  open override func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == T {
    super.appendItems(items)
    tableView?.reloadData()
  }
  
  open override func insert(_ item: T, atIndex index: Int) {
    super.insert(item, atIndex: index)
    tableView?.reloadData()
  }
  

  
}
