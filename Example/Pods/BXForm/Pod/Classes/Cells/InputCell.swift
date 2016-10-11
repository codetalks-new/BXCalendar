//
//  InputCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/23.
//
//


// Build for target uimodel
import UIKit
import BXModel
import BXiOSUtils
import PinAuto

//-InputCell:stc
//_[l15,y,w72](f17,cst)
//_[l18,y,r15](f15,cht):f

open class InputCell : StaticTableViewCell{
  open let label = UILabel(frame:CGRect.zero)
  open let textField = UITextField(frame:CGRect.zero)
  
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "InputCellCell")
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
    return [label,textField]
  }
  var allUILabelOutlets :[UILabel]{
    return [label]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [textField]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open func installConstaints(){
    label.pa_centerY.install()
    label.pa_leading.eq(15).install()
    label.pa_width.eq(72).install()
    textField.pa_centerY.install()
    textField.pa_after(label, offset: sdp2dp(15)).install()
    textField.pa_trailing.eq(15).install()
  }
  
  open func setupAttrs(){
    label.textAlignment = .left
    label.textColor = FormColors.secondaryTextColor
    label.font = UIFont.systemFont(ofSize: 17)
    textField.textColor = UIColor.darkText
    textField.font = UIFont.systemFont(ofSize: 17)
    shouldHighlight = false
  }
}
