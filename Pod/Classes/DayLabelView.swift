//
//  DayLabelView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/23.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import BXiOSUtils
import BXForm

//-DayLabelView:v
//num[x,t8](f15,cpt)
//zh[x,bl2@num,b8](f12,cst)

class DayLabelView : UIView  ,BXBindable {
  let numLabel = UILabel(frame:CGRectZero)
  let zhLabel = UILabel(frame:CGRectZero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func bind(item:NSDate){
    numLabel.text  = item.days.description
    zhLabel.text  = item.chineseDaysString
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [numLabel,zhLabel]
  }
  var allUILabelOutlets :[UILabel]{
    return [numLabel,zhLabel]
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
    numLabel.pa_centerX.install()
    numLabel.pa_top.eq(4).install()
    zhLabel.pa_below(numLabel,offset:0).install()
    zhLabel.pa_centerX.install()
  }
  
  func setupAttrs(){
    if #available(iOS 8.2, *) {
        numLabel.font = UIFont.systemFontOfSize(sdp2dp(15), weight: UIFontWeightMedium)
    } else {
        numLabel.font = UIFont.systemFontOfSize(sdp2dp(15))
    }
    numLabel.textColor = FormColors.primaryTextColor
    zhLabel.textColor = FormColors.secondaryTextColor
    zhLabel.font = UIFont.systemFontOfSize(sdp2dp(12))
  }
  
  func updateTextColor(){
    numLabel.textColor = selected ? .whiteColor(): FormColors.primaryTextColor
    zhLabel.textColor =  selected ? .whiteColor(): FormColors.secondaryTextColor
  }
  
  var selected:Bool = false{
    didSet{
      backgroundColor =  selected ? FormColors.accentColor: nil
      layer.cornerRadius = selected ? bounds.width * 0.5 : 0
      updateTextColor()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = selected ? bounds.width * 0.5 : 0
  }
}
