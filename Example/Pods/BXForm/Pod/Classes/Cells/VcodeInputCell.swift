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


open class VcodeInputCell : StaticTableViewCell{
  open let inputGroupView = InputGroupView(frame:CGRect.zero)
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "VcodeInputCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  open override func awakeFromNib() {
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
  
  open func commonInit(){
    staticHeight = 44
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open func installConstaints(){
    inputGroupView.pac_edge(0)
  }
  
  open func setupAttrs(){
    backgroundColor = .white
    inputGroupView.showSpanButton = true
    inputGroupView.showSpanDivider = true
    vcodeTextField.placeholder = "请输入短信验证码"
    vcodeTextField.textColor = FormColors.primaryTextColor
    vcodeTextField.font = UIFont.systemFont(ofSize: 15)
    
    sendVcodeButton.setTitle("发送验证码", for: UIControlState())
    sendVcodeButton.setTitleColor(FormColors.accentColor, for: .normal)
    sendVcodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
  }
  
  open var sendVcodeButton:UIButton{
    return inputGroupView.spanButton
  }
  
  open var vcodeTextField:UITextField{
    return inputGroupView.textField
  }
  
  open var vcode:String{
    return vcodeTextField.text?.trimmed() ?? ""
  }
  
}
