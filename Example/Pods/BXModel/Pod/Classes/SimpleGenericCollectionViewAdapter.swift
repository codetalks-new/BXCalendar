//
//  SimpleGenericCollectionViewAdapter.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import UIKit


open class SimpleGenericCollectionViewAdapter<T:BXModelAware,V:UICollectionViewCell>: SimpleGenericDataSource<T>,UICollectionViewDelegate where V:BXBindable {
  open fileprivate(set) weak var collectionView:UICollectionView?
  open var didSelectedItem: DidSelectedItemBlock?
  open var preBindCellBlock:( (V,IndexPath) -> Void )?
  open var postBindCellBlock:( (V,IndexPath) -> Void )?
  
  public init(collectionView:UICollectionView? = nil,items:[T] = []){
    super.init(items: items)
    self.reuseIdentifier = simpleClassName(V.self)+"_cell"
    if let c = collectionView{
      bindTo(c)
    }
  }
  
 open func bindTo(_ collectionView:UICollectionView){
    self.collectionView = collectionView
    collectionView.delegate = self
    collectionView.dataSource = self
    if V.hasNib{
      collectionView.register(V.nib(), forCellWithReuseIdentifier: reuseIdentifier)
    }else{
      collectionView.register(V.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
  }
  
  open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.didSelectedItem?(itemAtIndexPath(indexPath),indexPath)
  }
  
  open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! V
    preBindCellBlock?(cell,indexPath)
    let model = itemAtIndexPath(indexPath)
    if let m = model as? V.ModelType{
      cell.bind(m)
    }
    postBindCellBlock?(cell,indexPath)
    return cell
  }
  
  
  
  open override func updateItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    super.updateItems(items)
    collectionView?.reloadData()
  }
  
  
  
  open override func appendItems<S : Sequence>(_ items: S) where S.Iterator.Element == ItemType {
    super.appendItems(items)
    collectionView?.reloadData()
  }
  
  
  
}
