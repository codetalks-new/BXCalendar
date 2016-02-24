//
//  ConfirmButtonBar.swift
//
//  Created by Haizhen Lee on 15/6/4.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//


import BXiOSUtils
import UIKit
import SwiftyJSON
import BXModel

// -ConfirmButtonBar:v
// cancel[h34,w102,y,x35](cdt):b;ok[h34,w102,y,x35](cw):b
public typealias OnCancelHandler = (Void -> Void)
public typealias OnOkHandler = (Void -> Void)

public class ConfirmButtonBar : UIView{
  public let cancelButton = UIButton(type:.System)
  public let okButton = UIButton(type:.System)
  public var onCancelHandler:OnCancelHandler?
  public var onOkHandler:OnOkHandler?
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [cancelButton,okButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [cancelButton,okButton]
  }
  
  public required init?(coder aDecoder: NSCoder) {
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
    cancelButton.pinCenterY()
    cancelButton.pinHeight(34)
    cancelButton.pinWidth(102)
    cancelButton.pinTrailingToCenterX(dp2dp(40))
    
    okButton.pinCenterY()
    okButton.pinHeight(34)
    okButton.pinWidth(102)
    okButton.pinLeadingToCenterX(dp2dp(40))
    
  }
  
  func setupAttrs(){
    cancelButton.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
    okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    cancelButton.setTitle("取消", forState: .Normal)
    okButton.setTitle("确定", forState: .Normal)
    
    cancelButton.setBackgroundImage(FormButtons.lightGrayImage, forState: .Normal)
    okButton.setBackgroundImage(FormButtons.primaryImage, forState: .Normal)
    
    cancelButton.addTarget(self, action: "onCancelButtonPressed:", forControlEvents: .TouchUpInside)
    okButton.addTarget(self, action: "onOkButtonPressed:", forControlEvents: .TouchUpInside)
  }
  
  @IBAction func onCancelButtonPressed(sender:AnyObject){
   self.onCancelHandler?()
  }
  
  @IBAction func onOkButtonPressed(sender:AnyObject){
   self.onOkHandler?()
  }
  
  
  
  
  public func onCancel(handler:OnCancelHandler?) -> Self{
    self.onCancelHandler = handler
    return self
  }
  
  public func onOk(handler:OnOkHandler?) -> Self{
    self.onOkHandler = handler
    return self
  }
}

