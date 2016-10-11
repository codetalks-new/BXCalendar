//
//  WeekdayBar.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import Foundation
import UIKit
import BXModel
import BXiOSUtils
import BXForm

let weekdays  = "一二三四五六日".characters.map{ String($0)}


//-IdleTimeHeaderView:v

open class WeekdayBar : GridView{
  
  lazy var weekdayHeaders :[UILabel] = {
    return weekdays.map{ WeekdayBar.createWeekdayHeader($0) }
  }()
  
  let placeHolder = UIView(frame: CGRect.zero)
  
  static func createWeekdayHeader(_ weekday:String) -> UILabel{
    let label = UILabel(frame: CGRect.zero)
    label.text = weekday
    return label
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return weekdayHeaders
  }
  
  func commonInit(){
    updateChildViews(allOutlets)
    setupAttrs()
    
  }
  
  func setupAttrs(){
    backgroundColor = FormColors.accentColor
    for label in weekdayHeaders{
      label.font = UIFont.systemFont(ofSize: 15)
      label.textColor = .white
    }
  }
}
