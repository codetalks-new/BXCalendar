//
//  SwitchCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/24.
//
//

import UIKit
import PinAuto
import BXModel

// -SwitchCell:tc
// toggle[x,r15]:sw

public class SwitchCell : StaticTableViewCell,BXBindable{
  public let toggleSwitch = UISwitch(frame:CGRectZero)
  
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "SwitchCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  public func bind(item:Bool){
    toggleSwitch.on = item
    contentView.bringSubviewToFront(toggleSwitch)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [toggleSwitch]
  }
  var allUISwitchOutlets :[UISwitch]{
    return [toggleSwitch]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    staticHeight = 44
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    toggleSwitch.pa_centerY.install()
    toggleSwitch.pa_trailing.eq(15).install()
    
  }
  
  func setupAttrs(){
    backgroundColor = .whiteColor()
  }
}
