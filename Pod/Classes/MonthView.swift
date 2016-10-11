//
//  MonthView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/23.
//
//

import UIKit
import BXForm
import BXModel
import PinAuto

open class MonthView:UICollectionView{
  open let monthDate:Foundation.Date
  
  fileprivate lazy var flowLayout:UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.itemSize = CGSize(width:55,height:25)
//    flowLayout.estimatedItemSize = flowLayout.itemSize
    flowLayout.minimumLineSpacing = 0
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.scrollDirection = .vertical
    return flowLayout
  }()
  
  let adapter = SimpleGenericCollectionViewAdapter<Foundation.Date,NSDateCell>()
  let monthDates:[Foundation.Date]
  let gridDates:[Foundation.Date]
  
  open var readonly = false{
    didSet{
      isUserInteractionEnabled = !readonly
    }
  }
  
  public init(date:Foundation.Date){
    self.monthDate = date
    self.monthDates = generateMonthDaysByDate(date)
    self.gridDates = gridDatesFromMonthDates(self.monthDates)
    super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    self.collectionViewLayout = self.flowLayout
    
    allowsMultipleSelection =  true
    allowsSelection = true
    
    isUserInteractionEnabled = !readonly
    
    adapter.updateItems(self.gridDates)
    adapter.bindTo(self)
    
    adapter.didSelectedItem = { date,index in
     DateManager.sharedManager.toggleAdd(date)
    }
    for (index,day) in gridDates.enumerated(){
      if DateManager.sharedManager.contains(day){
        let indexPath = IndexPath(item: index, section: 0)
        selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
      }
    }
    
    
  }
  
  

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func autoUpdateItemSize(){
    let itemWidth = frame.width / CGFloat(weekdays.count)
    let itemHeight1 = itemWidth
    let itemHeight2 = frame.height / 6
    let itemHeight = min(itemHeight1,itemHeight2)
    let itemSize = CGSize(width: itemWidth, height: itemHeight)
    flowLayout.itemSize = itemSize
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    autoUpdateItemSize()
  }
  
  open var month:Int{
    return monthDate.month
  }
}

let timeIntervalOfDay:TimeInterval = 24 * 60 * 60



func generateMonthDaysByDate(_ date:Foundation.Date) -> [Foundation.Date]{
  let calendar = Calendar.current
  let day = calendar.component(.day, from: date)
  let ordinalRange = calendar.range(of: .day, in: .month, for: date)!
  
  var dates = [Date]()
  for ordinal in CountableRange(ordinalRange) {
    let diff = TimeInterval(ordinal - day) * timeIntervalOfDay
    let newDate = date.addingTimeInterval(diff)
    dates.append(newDate)
  }
  
  return dates
}

let placeholderDate = Foundation.Date(timeIntervalSince1970: 0)

func gridDatesFromMonthDates(_ monthDates:[Foundation.Date]) -> [Foundation.Date]{
  var dates = monthDates
  let monthStartDate = monthDates[0]
  let weekday = (calendar as NSCalendar).component(.weekday, from: monthStartDate)
  let paddingDayCount = weekday == 1 ? 6 : weekday - 2
  if paddingDayCount  < 1{
    return dates
  }
  var paddingDates:[Foundation.Date] = []
  for _ in (1...paddingDayCount).reversed(){
//    let days = NSTimeInterval(i)
//    let newDate = monthStartDate.dateByAddingTimeInterval(-(days * timeIntervalOfDay))
//    paddingDates.append(newDate)
    paddingDates.append(placeholderDate)
  }
  
  dates.insert(contentsOf: paddingDates, at: 0)
  return dates
  
}

extension Foundation.Date{
  var isPlaceholder:Bool{
    return timeIntervalSince1970 < timeIntervalOfDay
  }
}
