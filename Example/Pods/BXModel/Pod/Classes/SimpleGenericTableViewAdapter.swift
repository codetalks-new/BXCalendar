//
//  SimpleGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit

public class SimpleGenericTableViewAdapter<T,V:UITableViewCell where V:BXBindable >: SimpleGenericDataSource<T>,UITableViewDelegate{
    public private(set) weak var tableView:UITableView?
    public var didSelectedItem: DidSelectedItemBlock?
    public var preBindCellBlock:( (V,NSIndexPath) -> Void )?
    public var configureCellBlock:( (V,NSIndexPath) -> Void )?
    public var allowSelection = false
    public init(tableView:UITableView? = nil,items:[T] = []){
        super.init(items: items)
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
    
   public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.didSelectedItem?(itemAtIndexPath(indexPath),atIndexPath:indexPath)
        if !allowSelection{
          tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
   public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRowAtIndexPath(indexPath)
    }
    
    public func cellForRowAtIndexPath(indexPath:NSIndexPath) -> V {
         let cell = tableView!.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! V
        let model = itemAtIndexPath(indexPath)
         preBindCellBlock?(cell,indexPath)
        if let m = model as? V.ModelType{
            cell.bind(m)
        }
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    public func configureCell(cell:V,atIndexPath indexPath:NSIndexPath){
        self.configureCellBlock?(cell,indexPath)
    }
    
  public override func updateItems<S:SequenceType where S.Generator.Element == T>(items: S) {
        super.updateItems(items)
        tableView?.reloadData()
    }
 
  public override func appendItems<S : SequenceType where S.Generator.Element == T>(items: S) {
    super.appendItems(items)
    tableView?.reloadData()
  }

  public override func insert(item: T, atIndex index: Int) {
    super.insert(item, atIndex: index)
    tableView?.reloadData()
  }
    
}