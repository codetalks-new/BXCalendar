//
//  LoginButtonCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/23.
//
//

import UIKit
import BXModel
import BXiOSUtils
import PinAuto

//-LoginButtonCell:stc
//login[t18,l10,r10,h50](cw,f18,text=登录):b
//reg[at10@login,bl14@login](f15,ctt,text=快速注册):b
//reset[bf10@login,y@reg](f15,ctt,text=忘记密码):b

public class LoginButtonCell : StaticTableViewCell{
  public let loginButton = UIButton(type:.System)
  public let regButton = UIButton(type:.System)
  public let resetButton = UIButton(type:.System)
  
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "LoginButtonCellCell")
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
    return [loginButton,regButton,resetButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [loginButton,regButton,resetButton]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
    staticHeight = 120
    frame = CGRect(x: 0, y: 0, width: 320, height: staticHeight)
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    loginButton.pa_height.eq(50).install()
    loginButton.pa_trailing.eq(10).install()
    loginButton.pa_top.eq(5).install()
    loginButton.pa_leading.eq(10).install()
    regButton.pa_below(loginButton,offset:14).install()
    regButton.pa_leading.to(loginButton).offset(10).install()
    resetButton.pa_centerY.to(regButton).install()
    resetButton.pa_trailing.to(loginButton).offset(10).install()
  }
  
  public func setupAttrs(){
    loginButton.setTitle("登录",forState: .Normal)
    loginButton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
    loginButton.titleLabel?.font = UIFont.systemFontOfSize(18)
    regButton.setTitleColor(FormColors.tertiaryTextColor,forState: .Normal)
    regButton.setTitle("快速注册",forState: .Normal)
    regButton.titleLabel?.font = UIFont.systemFontOfSize(15)
    resetButton.setTitleColor(FormColors.tertiaryTextColor,forState: .Normal)
    resetButton.setTitle("忘记密码",forState: .Normal)
    resetButton.titleLabel?.font = UIFont.systemFontOfSize(15)
  }
}
