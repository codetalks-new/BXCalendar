//
//  SimpleMutipleSectionGenericTableViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation
open class BXMutipleSectionGenericDataSource<Key:Hashable,T:BXModelAware>:NSObject,UITableViewDataSource,UICollectionViewDataSource{
  open var reuseIdentifier = "cell"
  var dict:Dictionary<Key,[T]> = [:]
  public typealias DidSelectedItemBlock = ( (T,_ atIndexPath:IndexPath) -> Void )
  
  var sectionKeys:[Key] = []
  var shouldShowSectionHeaderTitle = true
  
  public init(dict:Dictionary<Key,[T]>){
    self.dict = dict
    sectionKeys = Array(dict.keys)
  }
  
  open func itemAtIndexPath(_ indexPath:IndexPath) -> T{
    let sectionKey = sectionKeys[(indexPath as NSIndexPath).section]
    return dict[sectionKey]![(indexPath as NSIndexPath).row]
  }
  
  open func rowsOfSection(_ section:Int) -> Int {
    let sectionKey = sectionKeys[section]
    return dict[sectionKey]!.count
  }
//
//  
  // MARK: UITableViewDataSource
  open func numberOfSections(in tableView: UITableView) -> Int {
    return sectionKeys.count
  }
//
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowsOfSection(section)
  }
  
  open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if shouldShowSectionHeaderTitle{
      return "\(self.sectionKeys[section])"
    }else{
      return nil
    }
  }
  
//
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
    configureTableViewCell(cell, atIndexPath: indexPath)
    return cell
  }
//
//  // MARK: UICollectionViewDataSource
//  
  public final func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sectionKeys.count
  }
//
  public final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return rowsOfSection(section)
  }
//
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
    configureCollectionViewCell(cell, atIndexPath: indexPath)
    return cell
  }
  
  // MARK : Helper
  
  open func configureCollectionViewCell(_ cell:UICollectionViewCell,atIndexPath indexPath:IndexPath){
    
  }
//
  open func configureTableViewCell(_ cell:UITableViewCell,atIndexPath indexPath:IndexPath){
    
  }
//
//  // MARK: BXDataSourceContainer
  open func updateDict(_ dict:Dictionary<Key,[T]>){
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
