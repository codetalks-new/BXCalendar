//
//  BasicInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/6.
//  Copyright © 2016年 xiyili. All rights reserved.
//


import UIKit
import BXModel
import BXiOSUtils


public class BasicInputCell : StaticTableViewCell{
  public let textField = UITextField(frame:CGRectZero)
  
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "BasicInputCellCell")
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
    return [textField]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [textField]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
    staticHeight = 65
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    textField.pinTrailing(15)
    textField.pinBottom(10)
    textField.pinLeading(15)
    textField.pinTop(10)
    
  }
  
  public func setupAttrs(){
    textField.font = UIFont.systemFontOfSize(15)
  }
}

