//
//  RadioButtonCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit
import BXModel

public class RadioButtonCell : UICollectionViewCell,BXBindable,UICollectionViewDelegate{
  public let radioButton = CheckboxButton(type:.Custom)
  override public var selected:Bool{
    didSet{
      radioButton.selected = selected
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public func bind(item:BXRadioItemAware){
    radioButton.setTitle(item.bx_title, forState: .Normal)
  }
  
  public override func awakeFromNib() {
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
    radioButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    radioButton.titleLabel?.font = UIFont.systemFontOfSize(14)
    radioButton.userInteractionEnabled = false
  }
  
}