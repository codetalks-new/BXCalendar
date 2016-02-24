//
//  PrimaryButtonTableViewCell.swift
//  VV3CV4
//
//  Created by Haizhen Lee on 15/11/3.
//  Copyright © 2015年 vv3c. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils

// -PrimaryButtonCell
// primary[l42,t50,r42,h44]:b;span[r0,b8]:b

public class PrimaryButtonCell : StaticTableViewCell{
  public let primaryButton = UIButton(type:.System)
  public let spanButton = UIButton(type:.System)
  public var primaryButtonTrailing: NSLayoutConstraint!
  public var primaryButtonLeading: NSLayoutConstraint!
  public var primaryButtonHeight:NSLayoutConstraint!
  public var buttonTop: NSLayoutConstraint!
  
  public init() {
    super.init(style: .Default, reuseIdentifier: "PrimaryButtonCell")
    commonInit()
  
  }
  
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [primaryButton,spanButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [primaryButton,spanButton]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
 
  public var buttonHorizontalInset:CGFloat{
    get{
      return primaryButtonLeading.constant
    }set{
      primaryButtonLeading.constant = newValue
      primaryButtonTrailing.constant = newValue
    }
  }
  
  public var buttonHeight:CGFloat{
    get{
      return primaryButtonHeight.constant
    }set{
      primaryButtonHeight.constant = newValue
    }
  }
  
  public var buttonMarginTop:CGFloat{
    get{
      return buttonTop.constant
    }set{
      buttonTop.constant = newValue
    }
  }
 
  public func commonInit(){
    frame = CGRect(x: 0, y: 0, width: 320, height: 160)
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    primaryButtonHeight = primaryButton.pinHeight(50)
    primaryButtonTrailing =  primaryButton.pinTrailing(dp2dp(42))
    primaryButtonLeading =  primaryButton.pinLeading(dp2dp(42))
    buttonTop =  primaryButton.pinTop(50)
    
    spanButton.pinTrailingEqualWithSibling(primaryButton)
    spanButton.pinAboveSibling(primaryButton, margin: 8)
    
  }
  
  func setupAttrs(){
    backgroundColor = FormColors.backgroundColor
    primaryButton.setupAsPrimaryActionButton()
    setPrimaryActionTitle("完成")
    spanButton.hidden = true //  currently only for login
    primaryButton.enabled = true
    primaryButton.userInteractionEnabled = true
  }
  
  public func setPrimaryActionTitle(title:String){
    primaryButton.setTitle(title, forState: .Normal)
  }
}
