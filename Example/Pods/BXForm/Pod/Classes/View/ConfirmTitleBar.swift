//
//  ConfirmTitleBar.swift

import Foundation

import UIKit
import BXModel
import BXiOSUtils

// -TitleBar:v
// cancel[l4,w40,ver0]:b
// title[l4,r4,y](f17,cpt)
// ok[r4,w40,ver0]:b


public class ConfirmTitleBar : UIView,BXBindable {
  public let cancelButton = UIButton(type:.System)
  public let titleLabel = UILabel(frame:CGRectZero)
  public let okButton = UIButton(type:.System)
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public func bind(item:String){
    titleLabel.text  = item
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [cancelButton,titleLabel,okButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [cancelButton,okButton]
  }
  var allUILabelOutlets :[UILabel]{
    return [titleLabel]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    cancelButton.pac_vertical() // pac_vertical(0)
    cancelButton.pa_leading.eq(4).install() // pa_leading.eq(4)
    cancelButton.pa_width.eq(40).install() // pa_width.eq(40)
    
    titleLabel.pa_centerY.install() //pa_centerY.install()
    titleLabel.pa_before(okButton, offset: 4).install() //pa_before(okButton, margin: 4)
    titleLabel.pa_after(cancelButton, offset: 4).install() // pinLeadingToSibling(cancelButton, margin: 4)
    titleLabel.setContentHuggingPriority(200, forAxis: .Horizontal)
    titleLabel.setContentCompressionResistancePriority(700, forAxis: .Horizontal)
    
    okButton.pa_trailing.eq(4).install() //pa_trailing.eq(4)
    okButton.pac_vertical() //pac_vertical(0)
    okButton.pa_width.eq(40).install() //pa_width.eq(40)
    
  }
  
  public func setupAttrs(){
    titleLabel.textColor = FormColors.primaryTextColor
    titleLabel.font = UIFont.systemFontOfSize(17)
    titleLabel.textAlignment = .Center
    okButton.hidden = true
    cancelButton.setTitle("取消", forState: .Normal)
    backgroundColor = .whiteColor()
  }
  
  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    UIColor(white: 0.914, alpha: 1.0).set()
    let shadowRect = rect.divide(1, fromEdge: CGRectEdge.MaxYEdge).slice
    UIRectFill(shadowRect)
  }
}

