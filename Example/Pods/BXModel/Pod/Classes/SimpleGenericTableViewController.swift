//
//  SimpleGenericTableViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/20.
//
//

import UIKit

public class SimpleGenericTableViewController<T,V:UITableViewCell where V:BXBindable>: UITableViewController{
  var adapter:SimpleGenericTableViewAdapter<T,V>?
 
  public typealias DidSelectedItemBlock = ( (T,atIndexPath:NSIndexPath) -> Void )
  public var didSelectedItemBlock: DidSelectedItemBlock?{
    didSet{
      adapter?.didSelectedItem = didSelectedItemBlock
    }
  }
  public override init(style: UITableViewStyle) {
    super.init(style: style)
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = 88
    tableView.rowHeight = UITableViewAutomaticDimension
    adapter = SimpleGenericTableViewAdapter(tableView:tableView)
    adapter?.didSelectedItem = didSelectedItemBlock
    if !_copyItems.isEmpty{
      adapter?.updateItems(_copyItems)
      // 有可能
    }
  }
  
  var _copyItems = [T]()

  
}

//MARK: BXDataSourceContainer
extension SimpleGenericTableViewController:BXDataSourceContainer{
  public typealias ItemType = T
  
  public func updateItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    _copyItems.removeAll()
    _copyItems.appendContentsOf(items)
    if let adapter = adapter{
      adapter.updateItems(items)
    }
  }
  
  public func appendItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    _copyItems.appendContentsOf(items)
    if let adapter = adapter{
      adapter.appendItems(items)
    }
  }
  
  public var numberOfItems:Int { return _copyItems.count }
}


// MARK:SimpleGenericTableViewController - Helper
public extension SimpleGenericTableViewController{
  public func itemAtIndexPath(indexPath:NSIndexPath) -> T{
    return _copyItems[indexPath.row]
  }
  
  public func numberOfRows() -> Int {
    return self._copyItems.count
  }
}
