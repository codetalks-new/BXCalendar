//
//  UpDownPairLabel.swift
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils
import BXForm

//-UpDownPairLabel:v
//top[x,t0](f11,ca)
//bottom[x,b0,bl8@top](f21,ca)

open class UpDownPairLabel : UIControl {
  open let topLabel = UILabel(frame:CGRect.zero)
  open let bottomLabel = UILabel(frame:CGRect.zero)
 
  
  open func bind(_ topLabel:String, bottomLabel:String=""){
    self.topLabel.text = topLabel
    self.bottomLabel.text = bottomLabel
  }
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [topLabel,bottomLabel]
  }
  var allUILabelOutlets :[UILabel]{
    return [topLabel,bottomLabel]
  }
  
  func commonInit(){
    translatesAutoresizingMaskIntoConstraints = false
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
 
  open class override var requiresConstraintBasedLayout : Bool{
    return true
  }
  
  var innerSpaceConstraint:NSLayoutConstraint?
 
  open var topBottomSpace:CGFloat = 4{
    didSet{
      innerSpaceConstraint?.constant = topBottomSpace
      invalidateIntrinsicContentSize()
    }
  }
  
  func installConstaints(){
    topLabel.pa_centerX.install()
    topLabel.pa_top.eq(0).install()
    
    innerSpaceConstraint =  bottomLabel.pa_below(topLabel,offset:topBottomSpace).install()
    bottomLabel.pa_centerX.install()
    bottomLabel.pa_bottom.eq(0).install()
    
  }
  
  open override var intrinsicContentSize : CGSize {
    let topSize = topLabel.intrinsicContentSize
    let bottomSize = bottomLabel.intrinsicContentSize
    let width = max(bottomSize.width,topSize.width)
    let height = topSize.height + topBottomSpace + bottomSize.height
    return CGSize(width: width, height: height)
  }
  
  func setupAttrs(){
    topLabel.textColor = FormColors.accentColor
    topLabel.font = UIFont.systemFont(ofSize: 21)
    
    bottomLabel.textColor = FormColors.primaryTextColor
    bottomLabel.font = UIFont.systemFont(ofSize: FormMetrics.tertiaryFontSize)
    
  }
}
