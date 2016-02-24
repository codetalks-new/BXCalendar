//
//  DayView.swift
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

//-DayView:v
//dayLabel[l0,t0,r0,b24]:v
//indicator[x,bl4@dayLabel,w8,a1]:v

class DayView : UIView  ,BXBindable {
  let dayLabelView = DayLabelView(frame:CGRectZero)
  let indicatorView = UIView(frame:CGRectZero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func bind(item:NSDate){
    dayLabelView.bind(item)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [dayLabelView,indicatorView]
  }
  var allUIViewOutlets :[UIView]{
    return [dayLabelView,indicatorView]
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
    dayLabelView.pa_trailing.eq(4).install()
    dayLabelView.pa_leading.eq(4).install()
    dayLabelView.pa_top.eq(0).install()
    dayLabelView.pa_aspectRatio(1.0).install()
    
    indicatorView.pa_below(dayLabelView,offset:0).install()
    indicatorView.pa_centerX.install()
    indicatorView.pa_aspectRatio(1).install()
    indicatorView.pa_width.eq(8).install()
  }
  
  func setupAttrs(){
  }
  
  var selected:Bool = false{
    didSet{
      dayLabelView.selected = selected
    }
  }
}
