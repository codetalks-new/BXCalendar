//
//  BXCalendarViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import Foundation

// Build for target uicontroller
import UIKit
import BXModel
import BXiOSUtils
import BXForm

//-BXCalendarViewController:vc
//monthHeader[hor0,t0,h48]:v
//weekdayBar[hor0,bl0@monthHeader,h36]:v
//month[hor0,bl0@weekdayBar,b0]:v

class BXCalendarMonthViewController : UIViewController {
  
  let monthHeaderView = MonthHeaderView(frame:CGRectZero)
  let weekdayBarView = WeekdayBar(frame:CGRectZero)
  lazy var monthView  :MonthView = {
    return MonthView(date: self.monthDate)
  }()
  
  convenience init(){
    self.init(nibName: nil, bundle: nil)
  }
  // must needed for iOS 8
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [monthHeaderView,weekdayBarView,monthView]
  }
  var allUIViewOutlets :[UIView]{
    return [monthHeaderView,weekdayBarView,monthView]
  }
  
  func commonInit(){
    for childView in allOutlets{
      self.view.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
  }
  
  func installConstaints(){
    monthHeaderView.pa_height.eq(sdp2dp(48)).install()
    monthHeaderView.pac_horizontal(0)
    monthHeaderView.pa_below(self.topLayoutGuide).offset(0).install()
    weekdayBarView.pa_below(monthHeaderView,offset:0).install()
    weekdayBarView.pa_height.eq(sdp2dp(36)).install()
    weekdayBarView.pac_horizontal(0)
    monthView.pa_below(weekdayBarView,offset:8).install()
    monthView.pa_above(self.bottomLayoutGuide).offset(0).install()
    monthView.pac_horizontal(0)
  }
  
  func setupAttrs(){
  }
  override func loadView(){
    super.loadView()
    self.view.backgroundColor = .whiteColor()
    monthView.backgroundColor = .whiteColor()
    monthHeaderView.backgroundColor = FormColors.accentColor
    commonInit()
  }
  
  
  var monthDate:NSDate = NSDate()
  var readonly = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = ""
    navigationItem.title = title
   
    monthHeaderView.backgroundColor = FormColors.accentColor
    monthHeaderView.bind(monthDate)
    monthView.readonly = readonly
    
  }
  
}



