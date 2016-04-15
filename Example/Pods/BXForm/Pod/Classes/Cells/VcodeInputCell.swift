//
//  VcodeInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/7.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils


public class VcodeInputCell : StaticTableViewCell{
  public let inputGroupView = InputGroupView(frame:CGRectZero)
  
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "VcodeInputCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [inputGroupView]
  }
  var allUIViewOutlets :[UIView]{
    return [inputGroupView]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
    staticHeight = 44
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    inputGroupView.pac_edge(0)
  }
  
  public func setupAttrs(){
    backgroundColor = .whiteColor()
    inputGroupView.showSpanButton = true
    inputGroupView.showSpanDivider = true
    vcodeTextField.placeholder = "请输入短信验证码"
    vcodeTextField.textColor = FormColors.primaryTextColor
    vcodeTextField.font = UIFont.systemFontOfSize(15)
    
    sendVcodeButton.setTitle("发送验证码", forState: .Normal)
    sendVcodeButton.setTitleColor(FormColors.accentColor, forState: .Normal)
    sendVcodeButton.titleLabel?.font = UIFont.systemFontOfSize(13)
  }
  
  public var sendVcodeButton:UIButton{
    return inputGroupView.spanButton
  }
  
  public var vcodeTextField:UITextField{
    return inputGroupView.textField
  }
  
  public var vcode:String{
    return vcodeTextField.text?.trimmed() ?? ""
  }
  
}
