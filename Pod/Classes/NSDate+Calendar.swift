//
//  NSDate+ChineseCalendar.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/23.
//
//

import Foundation

let calendar = Calendar.current

let chineseCalendar = Calendar(identifier: Calendar.Identifier.chinese)

public extension Foundation.Date{
 
  var chineseDays:Int{
    return (chineseCalendar as NSCalendar).component(NSCalendar.Unit.day, from: self)
  }
  
  var chineseDaysString:String{
    return chineseCalendarDays[chineseDays - 1]
  }
}

public extension Foundation.Date{
  var nextMonthDate:Foundation.Date{
    return (calendar as NSCalendar).date(byAdding: .month, value: 1, to: self, options: [])!
  }
  
  var prevMonthDate:Foundation.Date{
    return (calendar as NSCalendar).date(byAdding: .month, value: -1, to: self, options: [])!
  }
}

