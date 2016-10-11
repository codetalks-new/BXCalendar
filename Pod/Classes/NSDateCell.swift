//
//  NSDateCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import BXiOSUtils
import BXForm

//-NSDateCell(m=NSDate):cc
//day[e0]:v

class NSDateCell : UICollectionViewCell  ,BXBindable {
  let dayView = DayView(frame:CGRect.zero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  var date:Foundation.Date = Foundation.Date()
  func bind(_ item:Foundation.Date){
    self.date = item
    if !item.isPlaceholder{
      dayView.bind(item)
    }
    dayView.isHidden = item.isPlaceholder
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [dayView]
  }
  var allUIViewOutlets :[UIView]{
    return [dayView]
  }
  
  func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    dayView.pac_edge(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  func setupAttrs(){
  }
  
  override var isSelected: Bool{
    didSet{
      dayView.selected = isSelected
    }
  }
  
}
