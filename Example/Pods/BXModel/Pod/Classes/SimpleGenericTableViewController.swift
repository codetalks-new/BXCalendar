//
//  SimpleGenericTableViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/20.
//
//

import UIKit

open class SimpleGenericTableViewController<T,V:UITableViewCell>: UITableViewController where V:BXBindable{
  var adapter:SimpleGenericTableViewAdapter<T,V>?
 
  public typealias DidSelectedItemBlock = ( (T,_ atIndexPath:IndexPath) -> Void )
  open var didSelectedItemBlock: DidSelectedItemBlock?{
    didSet{
      adapter?.didSelectedItem = didSelectedItemBlock
    }
  }
  public override init(style: UITableViewStyle) {
    super.init(style: style)
  }
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  open override func viewDidLoad() {
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
  
  public func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    _copyItems.removeAll()
    _copyItems.append(contentsOf: items)
    if let adapter = adapter{
      adapter.updateItems(items)
    }
  }
  
  public func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    _copyItems.append(contentsOf: items)
    if let adapter = adapter{
      adapter.appendItems(items)
    }
  }
  
  public var numberOfItems:Int { return _copyItems.count }
}


// MARK:SimpleGenericTableViewController - Helper
public extension SimpleGenericTableViewController{
  public func itemAtIndexPath(_ indexPath:IndexPath) -> T{
    return _copyItems[(indexPath as NSIndexPath).row]
  }
  
  public func numberOfRows() -> Int {
    return self._copyItems.count
  }
}
