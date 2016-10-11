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


open class ConfirmTitleBar : UIView,BXBindable {
  open let cancelButton = UIButton(type:.system)
  open let titleLabel = UILabel(frame:CGRect.zero)
  open let okButton = UIButton(type:.system)
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  open func bind(_ item:String){
    titleLabel.text  = item
  }
  
  open override func awakeFromNib() {
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
  
  open func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open func installConstaints(){
    cancelButton.pac_vertical() // pac_vertical(0)
    cancelButton.pa_leading.eq(4).install() // pa_leading.eq(4)
    cancelButton.pa_width.eq(40).install() // pa_width.eq(40)
    
    titleLabel.pa_centerY.install() //pa_centerY.install()
    titleLabel.pa_before(okButton, offset: 4).install() //pa_before(okButton, margin: 4)
    titleLabel.pa_after(cancelButton, offset: 4).install() // pinLeadingToSibling(cancelButton, margin: 4)
    titleLabel.setContentHuggingPriority(200, for: .horizontal)
    titleLabel.setContentCompressionResistancePriority(700, for: .horizontal)
    
    okButton.pa_trailing.eq(4).install() //pa_trailing.eq(4)
    okButton.pac_vertical() //pac_vertical(0)
    okButton.pa_width.eq(40).install() //pa_width.eq(40)
    
  }
  
  open func setupAttrs(){
    titleLabel.textColor = FormColors.primaryTextColor
    titleLabel.font = UIFont.systemFont(ofSize: 17)
    titleLabel.textAlignment = .center
    okButton.isHidden = true
    cancelButton.setTitle("取消", for: UIControlState())
    backgroundColor = .white
  }
  
  open override func draw(_ rect: CGRect) {
    super.draw(rect)
    UIColor(white: 0.914, alpha: 1.0).set()
    let shadowRect = rect.divided(atDistance: 1, from: CGRectEdge.maxYEdge).slice
    UIRectFill(shadowRect)
  }
}

