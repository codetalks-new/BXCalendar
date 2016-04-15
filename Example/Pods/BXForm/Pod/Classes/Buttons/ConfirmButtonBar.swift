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

public enum ConfirmButtonBarStyle{
  case Plain
  case Bordered
  
  var isPlain:Bool{
    return self == .Plain
  }
}

// -ConfirmButtonBar:v
// cancel[h34,w102,y,x35](cdt):b;ok[h34,w102,y,x35](cw):b
public typealias OnCancelHandler = (Void -> Void)
public typealias OnOkHandler = (Void -> Void)

public class ConfirmButtonBar : UIView{
  public let cancelButton = UIButton(type:.System)
  public let okButton = UIButton(type:.System)
  public var onCancelHandler:OnCancelHandler?
  public var onOkHandler:OnOkHandler?
  var style:ConfirmButtonBarStyle = .Plain
  public  init(style:ConfirmButtonBarStyle){
    super.init(frame:CGRectZero)
    self.style = style
    commonInit()
  }
  
  
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
    if style.isPlain{
      cancelButton.pa_leading.eq(15).install()
      okButton.pa_trailing.eq(15).install()
      for button in [okButton,cancelButton]{
        button.pa_width.gte(40).install()
        button.pa_centerY.install()
      }
    }else{
    cancelButton.pa_centerY.install()
    cancelButton.pa_height.eq(34).install()
    cancelButton.pa_width.eq(102).install()
    cancelButton.pa_trailing.equalTo(.CenterX, ofView: self).eq(dp2dp(40)).install() //  pinTrailingToCenterX(dp2dp(40))
    
    okButton.pa_centerY.install()
    okButton.pa_height.eq(34).install()
    okButton.pa_width.eq(102).install()
    okButton.pa_leading.eq(dp2dp(40)).equalTo(.CenterX, ofView: self).install()
    }
    
  }
  
  func setupAttrs(){
    cancelButton.setTitle("取消", forState: .Normal)
    okButton.setTitle("确定", forState: .Normal)

    
    if style.isPlain{
      cancelButton.setTitleColor(FormColors.tertiaryTextColor, forState: .Normal)
      okButton.setTitleColor(UIColor(hex: 0xf23d3d), forState: .Normal)
      
      for button in [okButton,cancelButton]{
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
      }
    }else{
      cancelButton.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
      okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
      cancelButton.setBackgroundImage(FormButtons.lightGrayImage, forState: .Normal)
      okButton.setBackgroundImage(FormButtons.primaryImage, forState: .Normal)
    }
    
    cancelButton.addTarget(self, action: #selector(ConfirmButtonBar.onCancelButtonPressed(_:)), forControlEvents: .TouchUpInside)
    okButton.addTarget(self, action: #selector(ConfirmButtonBar.onOkButtonPressed(_:)), forControlEvents: .TouchUpInside)
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

