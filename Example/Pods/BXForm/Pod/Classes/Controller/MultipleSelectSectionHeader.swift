//
//  MultipleSelectSectionHeader.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit
import SwiftyJSON
import BXModel



// -MultipleSelectSectionHeader:tc
// selectAll[h36,y,r15]:b

class MultipleSelectSectionHeader : UITableViewCell{
  let selectAllButton = CheckboxButton(type:.Custom)
  
  
  convenience init() {
    self.init(style: .Default, reuseIdentifier: "MultipleSelectSectionHeaderCell")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [selectAllButton]
  }
  var allUIButtonOutlets :[CheckboxButton]{
    return [selectAllButton]
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    frame = CGRect(x: 0, y: 0, width: 320, height: 36)
    
  }
  
  func installConstaints(){
    selectAllButton.pinCenterY()
    selectAllButton.pinHeight(32)
    selectAllButton.pinTrailing(15)
    
  }
  
  func setupAttrs(){
    
  }
  func toggleSelectAll(){
    selectAllButton.toggle()
    let title = selectAllButton.selected ? "全不选":  "全选"
    selectAllButton.setTitle(title, forState: .Normal)
  }
}