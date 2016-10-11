//
//  RadioButtonCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit
import BXModel

open class RadioButtonCell : UICollectionViewCell,BXBindable,UICollectionViewDelegate{
  open let radioButton = CheckboxButton(type:.custom)
  override open var isSelected:Bool{
    didSet{
      radioButton.isSelected = isSelected
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  open func bind(_ item:BXRadioItemAware){
    radioButton.setTitle(item.bx_title, for: UIControlState())
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [radioButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [radioButton]
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
    radioButton.pac_edge(UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 ))
  }
  
  func setupAttrs(){
    radioButton.setTitleColor(UIColor.white, for: UIControlState())
    radioButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    radioButton.isUserInteractionEnabled = false
  }
  
}
