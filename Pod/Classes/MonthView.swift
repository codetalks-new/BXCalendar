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

public class MonthView:UICollectionView{
  public let monthDate:NSDate
  
  private lazy var flowLayout:UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.itemSize = CGSize(width:55,height:25)
//    flowLayout.estimatedItemSize = flowLayout.itemSize
    flowLayout.minimumLineSpacing = 0
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    flowLayout.scrollDirection = .Vertical
    return flowLayout
  }()
  
  let adapter = SimpleGenericCollectionViewAdapter<NSDate,NSDateCell>()
  let monthDates:[NSDate]
  let gridDates:[NSDate]
  
  public var readonly = false{
    didSet{
      userInteractionEnabled = !readonly
    }
  }
  
  public init(date:NSDate){
    self.monthDate = date
    self.monthDates = generateMonthDaysByDate(date)
    self.gridDates = gridDatesFromMonthDates(self.monthDates)
    super.init(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    self.collectionViewLayout = self.flowLayout
    
    allowsMultipleSelection =  true
    allowsSelection = true
    
    userInteractionEnabled = !readonly
    
    adapter.updateItems(self.gridDates)
    adapter.bindTo(self)
    
    adapter.didSelectedItem = { date,index in
     DateManager.sharedManager.toggleAdd(date)
    }
    for (index,day) in gridDates.enumerate(){
      if DateManager.sharedManager.contains(day){
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
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
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    autoUpdateItemSize()
  }
  
  public var month:Int{
    return monthDate.month
  }
}

let timeIntervalOfDay:NSTimeInterval = 24 * 60 * 60



func generateMonthDaysByDate(date:NSDate) -> [NSDate]{
  let calendar = NSCalendar.currentCalendar()
  let day = calendar.component(.Day, fromDate: date)
  let dayRange = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date).toRange()!
  var dates = [NSDate]()
  for ordinal in dayRange{
    let diff = NSTimeInterval(ordinal - day) * timeIntervalOfDay
    let newDate = date.dateByAddingTimeInterval(diff)
    dates.append(newDate)
  }
  
  return dates
}

let placeholderDate = NSDate(timeIntervalSince1970: 0)

func gridDatesFromMonthDates(monthDates:[NSDate]) -> [NSDate]{
  var dates = monthDates
  let monthStartDate = monthDates[0]
  let weekday = calendar.component(.Weekday, fromDate: monthStartDate)
  let paddingDayCount = weekday == 1 ? 6 : weekday - 2
  if paddingDayCount  < 1{
    return dates
  }
  var paddingDates:[NSDate] = []
  for _ in (1...paddingDayCount).reverse(){
//    let days = NSTimeInterval(i)
//    let newDate = monthStartDate.dateByAddingTimeInterval(-(days * timeIntervalOfDay))
//    paddingDates.append(newDate)
    paddingDates.append(placeholderDate)
  }
  
  dates.insertContentsOf(paddingDates, at: 0)
  return dates
  
}

extension NSDate{
  var isPlaceholder:Bool{
    return timeIntervalSince1970 < timeIntervalOfDay
  }
}