//
//  VerticalIconButton.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/29.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils
import BXForm

//-VerticalIconButton(al,nobind):ct
//icon[x,y]:i
//title[x,bl4@icon](f15,cpt)

open class VerticalIconButton : UIControl  {
  open var iconPadding = FormMetrics.iconPadding
  open let iconImageView = UIImageView(frame:CGRect.zero)
  open let titleLabel = UILabel(frame:CGRect.zero)
  
  
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
    return [iconImageView,titleLabel]
  }
  var allUIImageViewOutlets :[UIImageView]{
    return [iconImageView]
  }
  var allUILabelOutlets :[UILabel]{
    return [titleLabel]
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    iconImageView.pa_centerY.install()
    iconImageView.pa_centerX.install()
    
    titleLabel.pa_below(iconImageView,offset:iconPadding).install()
    titleLabel.pa_centerX.install()
    
  }
  
  func setupAttrs(){
    titleLabel.textColor = FormColors.primaryTextColor
    titleLabel.font = UIFont.systemFont(ofSize: 15)
    
  }
  
  open var icon:UIImage?{
    set{
      iconImageView.image = newValue
    }get{
      return iconImageView.image
    }
  }
  
  open class override var requiresConstraintBasedLayout : Bool{
    return true
  }
  
  open override var intrinsicContentSize : CGSize {
    let iconSize = iconImageView.intrinsicContentSize
    let titleSize = titleLabel.intrinsicContentSize
    let width = max(iconSize.width, titleSize.width)
    let height = iconSize.height + iconPadding + titleSize.height
    
    return CGSize(width: width, height: height)
  }
  
}

