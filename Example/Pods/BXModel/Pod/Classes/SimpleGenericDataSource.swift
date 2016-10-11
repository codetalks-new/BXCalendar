//
//  GenericDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit

public protocol BXDataSourceContainer{
  associatedtype ItemType
  func updateItems<S:Sequence>(_ items:S) where S.Iterator.Element == ItemType
  func appendItems<S:Sequence>(_ items:S) where S.Iterator.Element == ItemType
  var numberOfItems:Int{ get }
}

open class SimpleGenericDataSource<T>:NSObject,UITableViewDataSource,UICollectionViewDataSource,BXDataSourceContainer{
    open var reuseIdentifier = "cell"
    open fileprivate(set) var items = [T]()
    open var section = 0
    public typealias ItemType = T
    public typealias DidSelectedItemBlock = ( (T,_ atIndexPath:IndexPath) -> Void )
    
    public init(items:[T] = []){
        self.items = items
    }
    
   open func itemAtIndexPath(_ indexPath:IndexPath) -> T{
        return items[(indexPath as NSIndexPath).row]
    }
    
   open func numberOfRows() -> Int {
        return self.items.count
   }
  
    
    // MARK: UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        configureTableViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDataSource
    
   public final func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   public final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return numberOfRows()
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
   open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        configureCollectionViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK : Helper
    
    open func configureCollectionViewCell(_ cell:UICollectionViewCell,atIndexPath indexPath:IndexPath){
        
    }
    
   open func configureTableViewCell(_ cell:UITableViewCell,atIndexPath indexPath:IndexPath){
        
    }

  // MARK: BXDataSourceContainer
  // cause /Users/banxi/Workspace/BXModel/Pod/Classes/SimpleGenericTableViewAdapter.swift:50:25: Declarations from extensions cannot be overridden yet
  
  open func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    self.items.removeAll()
    self.items.append(contentsOf: items)
  }
  
  open func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    self.items.append(contentsOf: items)
  }
 
  open func insert(_ item:T,atIndex index :Int){
    self.items.insert(item, at: index)
  }
    open var numberOfItems:Int{
      return self.items.count
    }
  
}

extension SimpleGenericDataSource where T:Equatable{
  public func indexOfItem(_ item:T) -> Int?{
    return self.items.index(of: item)
  }
  
  public func removeAtIndex(_ index:Int) -> T{
    return items.remove(at: index)
  }
  
  public func removeItem(_ item:T) -> T?{
    if let index = indexOfItem(item){
      self.items.remove(at: index)
    }
    return nil
  }
  
  public func removeItems(_ items:[T]){
    for item in items{
      removeItem(item)
    }
  }
}
