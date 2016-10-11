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

open class LoginButtonCell : StaticTableViewCell{
  open let loginButton = UIButton(type:.system)
  open let regButton = UIButton(type:.system)
  open let resetButton = UIButton(type:.system)
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "LoginButtonCellCell")
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
    return [loginButton,regButton,resetButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [loginButton,regButton,resetButton]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open func commonInit(){
    staticHeight = 120
    frame = CGRect(x: 0, y: 0, width: 320, height: staticHeight)
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open func installConstaints(){
    loginButton.pa_height.eq(50).install()
    loginButton.pa_trailing.eq(10).install()
    loginButton.pa_top.eq(5).install()
    loginButton.pa_leading.eq(10).install()
    regButton.pa_below(loginButton,offset:14).install()
    regButton.pa_leading.to(loginButton).offset(10).install()
    resetButton.pa_centerY.to(regButton).install()
    resetButton.pa_trailing.to(loginButton).offset(10).install()
  }
  
  open func setupAttrs(){
    loginButton.setTitle("登录",for: UIControlState())
    loginButton.setTitleColor(UIColor.white,for: UIControlState())
    loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    regButton.setTitleColor(FormColors.tertiaryTextColor,for: .normal)
    regButton.setTitle("快速注册",for: UIControlState())
    regButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    resetButton.setTitleColor(FormColors.tertiaryTextColor,for: .normal)
    resetButton.setTitle("忘记密码",for: UIControlState())
    resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
  }
}
