//
//  RadioGroup.swift
//
//  Created by Haizhen Lee on 15/12/5.
//

import UIKit
import SwiftyJSON
import BXModel








// -RadioGroup:c

class RadioGroup<T:BXRadioItemAware> : UICollectionView where T:Equatable{
  
  let flowLayout : UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 72, height: 36)
    layout.minimumInteritemSpacing = 8
    layout.minimumLineSpacing = 0
    return layout
  }()
  
  
  lazy var adapter: SimpleGenericCollectionViewAdapter<T,RadioButtonCell> = {
   let adapter =  SimpleGenericCollectionViewAdapter<T,RadioButtonCell>(collectionView:self)
    adapter.didSelectedItem = {
    item,path in
      self.selectedIndexPath = path
  }
    return adapter
  }()
  
  init(frame:CGRect) {
    super.init(frame: frame, collectionViewLayout: flowLayout)
    commonInit()
  }
  
  func bind<S:Sequence>(_ items:S) where S.Iterator.Element == T{
    adapter.updateItems(items)
  }
  
  func selectItem(_ item:T){
    if let index = adapter.indexOfItem(item){
      let indexPath = IndexPath(item: index, section: 0)
      selectedIndexPath = indexPath
      selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return []
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  
  
  func installConstaints(){
  }
  
  func setupAttrs(){
    backgroundColor = .clear
  }
 
  var selectedIndexPath:IndexPath?
  var selectedItem:T?{
    if let path = selectedIndexPath{
      return adapter.itemAtIndexPath(path)
    }
    return nil
  }

  // UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
    selectedIndexPath = indexPath
  }
}
