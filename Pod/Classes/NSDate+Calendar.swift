//
//  NSDate+ChineseCalendar.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/23.
//
//

import Foundation

let calendar = NSCalendar.currentCalendar()

let chineseCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierChinese)!

public extension NSDate{
 
  var chineseDays:Int{
    return chineseCalendar.component(NSCalendarUnit.Day, fromDate: self)
  }
  
  var chineseDaysString:String{
    return chineseCalendarDays[chineseDays - 1]
  }
}

public extension NSDate{
  var nextMonthDate:NSDate{
    return calendar.dateByAddingUnit(.Month, value: 1, toDate: self, options: [])!
  }
  
  var prevMonthDate:NSDate{
    return calendar.dateByAddingUnit(.Month, value: -1, toDate: self, options: [])!
  }
}

