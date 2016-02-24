//
//  MonthHeaderView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import BXiOSUtils
import BXForm

// Build for target uimodel
import UIKit
import BXModel
import Bond
import CocoaLumberjack
import SwiftyJSON
import PromiseKit
import BXiOSUtils
import Kingfisher
import BXForm

//-MonthHeaderView(m=NSDate):v
//cancel[y,l15]:b
//ok[y,r15]:b
//month[x,y](f24,cw)
//year[x,bl2@month](f15,cw)

class MonthHeaderView : UIView  ,BXBindable {
  let cancelButton = UIButton(type:.System)
  let okButton = UIButton(type:.System)
  let monthLabel = UILabel(frame:CGRectZero)
  let yearLabel = UILabel(frame:CGRectZero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func bind(item:NSDate){
    monthLabel.text  = "\(item.month)月"
    yearLabel.text  = item.year.description
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [cancelButton,okButton,monthLabel,yearLabel]
  }
  var allUIButtonOutlets :[UIButton]{
    return [cancelButton,okButton]
  }
  var allUILabelOutlets :[UILabel]{
    return [monthLabel,yearLabel]
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
    cancelButton.pa_centerY.install()
    cancelButton.pa_leading.eq(15).install()
    okButton.pa_centerY.install()
    okButton.pa_trailing.eq(15).install()
    monthLabel.pa_centerY.install()
    monthLabel.pa_centerX.install()
    yearLabel.pa_before(monthLabel,offset:8).install()
    yearLabel.pa_centerY.install()
  }
  
  func setupAttrs(){
    monthLabel.textColor = UIColor.whiteColor()
    monthLabel.font = UIFont.systemFontOfSize(24)
    yearLabel.textColor = UIColor.whiteColor()
    yearLabel.font = UIFont.systemFontOfSize(15)
    
    cancelButton.setTitle("取消", forState: .Normal)
    okButton.setTitle("确定", forState: .Normal)
    cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
    okButton.setTitleColor(.whiteColor(), forState: .Normal)
  }
}



