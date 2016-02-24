//
//  SimpleMutipleSectionGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation
public class BXMutipleSectionGenericDataSource<Key:Hashable,T:BXModelAware where Key:StringInterpolationConvertible>:NSObject,UITableViewDataSource,UICollectionViewDataSource{
  public var reuseIdentifier = "cell"
  var dict:Dictionary<Key,[T]> = [:]
  public typealias DidSelectedItemBlock = ( (T,atIndexPath:NSIndexPath) -> Void )
  
  var sectionKeys:[Key] = []
  var shouldShowSectionHeaderTitle = true
  
  public init(dict:Dictionary<Key,[T]>){
    self.dict = dict
    sectionKeys = Array(dict.keys)
  }
  
  public func itemAtIndexPath(indexPath:NSIndexPath) -> T{
    let sectionKey = sectionKeys[indexPath.section]
    return dict[sectionKey]![indexPath.row]
  }
  
  public func rowsOfSection(section:Int) -> Int {
    let sectionKey = sectionKeys[section]
    return dict[sectionKey]!.count
  }
//
//  
  // MARK: UITableViewDataSource
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sectionKeys.count
  }
//
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowsOfSection(section)
  }
  
  public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if shouldShowSectionHeaderTitle{
      return "\(self.sectionKeys[section])"
    }else{
      return nil
    }
  }
  
//
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath)
    configureTableViewCell(cell, atIndexPath: indexPath)
    return cell
  }
//
//  // MARK: UICollectionViewDataSource
//  
  public final func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return sectionKeys.count
  }
//
  public final func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return rowsOfSection(section)
  }
//
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath)
    configureCollectionViewCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  // MARK : Helper
  
  public func configureCollectionViewCell(cell:UICollectionViewCell,atIndexPath indexPath:NSIndexPath){
    
  }
//
  public func configureTableViewCell(cell:UITableViewCell,atIndexPath indexPath:NSIndexPath){
    
  }
//
//  // MARK: BXDataSourceContainer
  public func updateDict(dict:Dictionary<Key,[T]>){
    self.dict = dict
    self.sectionKeys = Array(dict.keys)
  }
//
//  
//  public func appendItems(items:[T]){
//    self.items.appendContentsOf(items)
//  }
//  
//  public var numberOfItems:Int{
//    return self.items.count
//  }
}