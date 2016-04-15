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
  func updateItems<S:SequenceType where S.Generator.Element == ItemType>(items:S)
  func appendItems<S:SequenceType where S.Generator.Element == ItemType>(items:S)
  var numberOfItems:Int{ get }
}

public class SimpleGenericDataSource<T>:NSObject,UITableViewDataSource,UICollectionViewDataSource,BXDataSourceContainer{
    public var reuseIdentifier = "cell"
    public private(set) var items = [T]()
    public var section = 0
    public typealias ItemType = T
    public typealias DidSelectedItemBlock = ( (T,atIndexPath:NSIndexPath) -> Void )
    
    public init(items:[T] = []){
        self.items = items
    }
    
   public func itemAtIndexPath(indexPath:NSIndexPath) -> T{
        return items[indexPath.row]
    }
    
   public func numberOfRows() -> Int {
        return self.items.count
   }
  
    
    // MARK: UITableViewDataSource
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath)
        configureTableViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDataSource
    
   public final func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
   public final func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return numberOfRows()
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
   public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath)
        configureCollectionViewCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // MARK : Helper
    
    public func configureCollectionViewCell(cell:UICollectionViewCell,atIndexPath indexPath:NSIndexPath){
        
    }
    
   public func configureTableViewCell(cell:UITableViewCell,atIndexPath indexPath:NSIndexPath){
        
    }

  // MARK: BXDataSourceContainer
  // cause /Users/banxi/Workspace/BXModel/Pod/Classes/SimpleGenericTableViewAdapter.swift:50:25: Declarations from extensions cannot be overridden yet
  
  public func updateItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    self.items.removeAll()
    self.items.appendContentsOf(items)
  }
  
  public func appendItems<S : SequenceType where S.Generator.Element == ItemType>(items: S) {
    self.items.appendContentsOf(items)
  }
 
  public func insert(item:T,atIndex index :Int){
    self.items.insert(item, atIndex: index)
  }
    public var numberOfItems:Int{
      return self.items.count
    }
  
}

extension SimpleGenericDataSource where T:Equatable{
  public func indexOfItem(item:T) -> Int?{
    return self.items.indexOf(item)
  }
  
  public func removeAtIndex(index:Int) -> T{
    return items.removeAtIndex(index)
  }
  
  public func removeItem(item:T) -> T?{
    if let index = indexOfItem(item){
      self.items.removeAtIndex(index)
    }
    return nil
  }
  
  public func removeItems(items:[T]){
    for item in items{
      removeItem(item)
    }
  }
}