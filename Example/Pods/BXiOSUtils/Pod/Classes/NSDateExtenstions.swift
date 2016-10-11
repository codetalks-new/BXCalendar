//  File.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 23/11/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Date {
  
  // MARK:  NSDate Manipulation
  
  /**
  Returns a new NSDate object representing the date calculated by adding the amount specified to self date
  
  :param: seconds number of seconds to add
  :param: minutes number of minutes to add
  :param: hours number of hours to add
  :param: days number of days to add
  :param: weeks number of weeks to add
  :param: months number of months to add
  :param: years number of years to add
  :returns: the NSDate computed
  */
//  public func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> NSDate {
//    var calendar = NSCalendar.currentCalendar()
//    
//    let version = floor(NSFoundationVersionNumber)
//    
//    if version <= NSFoundationVersionNumber10_9_2 {
//      var component = NSDateComponents()
//      component.setValue(seconds, forComponent: .Second)
//      
//      var date : NSDate! = calendar.dateByAddingComponents(component, toDate: self, options: nil)!
//      component = NSDateComponents()
//      component.setValue(minutes, forComponent: .Minute)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      
//      component = NSDateComponents()
//      component.setValue(hours, forComponent: .Hour)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      
//      component = NSDateComponents()
//      component.setValue(days, forComponent: .Day)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      
//      component = NSDateComponents()
//      component.setValue(weeks, forComponent: .WeekOfMonth)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      
//      component = NSDateComponents()
//      component.setValue(months, forComponent: .Month)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      
//      component = NSDateComponents()
//      component.setValue(years, forComponent: .Year)
//      date = calendar.dateByAddingComponents(component, toDate: date, options: nil)!
//      return date
//    }
//    
//    var date : NSDate! = calendar.dateByAddingUnit(.CalendarUnitSecond, value: seconds, toDate: self, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitMinute, value: minutes, toDate: date, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitDay, value: days, toDate: date, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitHour, value: hours, toDate: date, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitWeekOfMonth, value: weeks, toDate: date, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitMonth, value: months, toDate: date, options: nil)
//    date = calendar.dateByAddingUnit(.CalendarUnitYear, value: years, toDate: date, options: nil)
//    return date
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date
//   
//   :param: seconds number of seconds to add
//   :returns: the NSDate computed
//   */
//  public func addSeconds (seconds: Int) -> NSDate {
//    return add(seconds: seconds)
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date
//   
//   :param: minutes number of minutes to add
//   :returns: the NSDate computed
//   */
//  public func addMinutes (minutes: Int) -> NSDate {
//    return add(minutes: minutes)
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of hours to self date
//   
//   :param: hours number of hours to add
//   :returns: the NSDate computed
//   */
//  public func addHours(hours: Int) -> NSDate {
//    return add(hours: hours)
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of days to self date
//   
//   :param: days number of days to add
//   :returns: the NSDate computed
//   */
//  public func addDays(days: Int) -> NSDate {
//    return add(days: days)
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date
//   
//   :param: weeks number of weeks to add
//   :returns: the NSDate computed
//   */
//  public func addWeeks(weeks: Int) -> NSDate {
//    return add(weeks: weeks)
//  }
//  
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of months to self date
//   
//   :param: months number of months to add
//   :returns: the NSDate computed
//   */
//  
//  public func addMonths(months: Int) -> NSDate {
//    return add(months: months)
//  }
//  
//  /**
//   Returns a new NSDate object representing the date calculated by adding an amount of years to self date
//   
//   :param: years number of year to add
//   :returns: the NSDate computed
//   */
//  public func addYears(years: Int) -> NSDate {
//    return add(years: years)
//  }
//  
  // MARK:  Date comparison
  
  /**
  Checks if self is after input NSDate
  
  :param: date NSDate to compare
  :returns: True if self is after the input NSDate, false otherwise
  */
  public func isAfter(_ date: Date) -> Bool{
    return (self.compare(date) == ComparisonResult.orderedDescending)
  }
  
  /**
   Checks if self is before input NSDate
   
   :param: date NSDate to compare
   :returns: True if self is before the input NSDate, false otherwise
   */
  public func isBefore(_ date: Date) -> Bool{
    return (self.compare(date) == ComparisonResult.orderedAscending)
  }
  
  
  // MARK: Getter
  
  /**
  Date year
  */
  public var year : Int {
    get {
      return getComponent(.year)
    }
  }
  
  /**
   Date month
   */
  public var month : Int {
    get {
      return getComponent(.month)
    }
  }
  
  /**
   Date weekday
   */
  public var weekday : Int {
    get {
      return getComponent(.weekday)
    }
  }
  
  /**
   Date weekMonth
   */
  public var weekMonth : Int {
    get {
      return getComponent(.weekOfMonth)
    }
  }
  
  
  /**
   Date days
   */
  public var days : Int {
    get {
      return getComponent(.day)
    }
  }
  
  /**
   Date hours
   */
  public var hours : Int {
    
    get {
      return getComponent(.hour)
    }
  }
  
  /**
   Date minuts
   */
  public var minutes : Int {
    get {
      return getComponent(.minute)
    }
  }
  
  /**
   Date seconds
   */
  public var seconds : Int {
    get {
      return getComponent(.second)
    }
  }
  
  /**
   Returns the value of the NSDate component
   
   :param: component NSCalendarUnit
   :returns: the value of the component
   */
  
  public func getComponent (_ component : Calendar.Component) -> Int {
    let calendar = Calendar.current
    return calendar.component(component, from:self)
  }
}

//extension NSDate: Strideable {
//  public func distanceTo(other: NSDate) -> NSTimeInterval {
//    return other - self
//  }
//  
//  public func advancedBy(n: NSTimeInterval) -> Self {
//    return NSDate(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate + n)
//  }
//}
// MARK: Arithmetic

//func +(date: Date, timeInterval: Int) -> Date {
//  return date + TimeInterval(timeInterval)
//}
//
//func -(date: Date, timeInterval: Int) -> Date {
//  return date - TimeInterval(timeInterval)
//}

//func +=(date: inout Date, timeInterval: Int) {
//  date = date + timeInterval
//}
//
//func -=(date: inout Date, timeInterval: Int) {
//  date = date - timeInterval
//}

//func +(date: Date, timeInterval: Double) -> Date {
//  return date.addingTimeInterval(TimeInterval(timeInterval))
//}
//
//func -(date: Date, timeInterval: Double) -> Date {
//  return date.addingTimeInterval(TimeInterval(-timeInterval))
//}

//func +=(date: inout Date, timeInterval: Double) {
//  date = date + timeInterval
//}
//
//func -=(date: inout Date, timeInterval: Double) {
//  date = date - timeInterval
//}

func -(date: Date, otherDate: Date) -> TimeInterval {
  return date.timeIntervalSince(otherDate)
}

//extension NSDate: Equatable {
//}
//
//public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
//  return lhs.compare(rhs) == NSComparisonResult.OrderedSame
//}

//extension Date: Comparable {
//}
//
//public func <(lhs: Date, rhs: Date) -> Bool {
//  return lhs.compare(rhs) == ComparisonResult.orderedAscending
//}



extension Date{
  public var bx_shortDateString:String{
    return bx_dateTimeStringWithFormatStyle(.short, timeStyle: .none)
  }
  
  public var bx_longDateString:String{
    return bx_dateTimeStringWithFormatStyle(.medium, timeStyle: .none)
  }
  
  public var bx_shortTimeString:String{
    return bx_dateTimeStringWithFormatStyle(.none, timeStyle: .short)
  }
  
  public var bx_dateTimeString:String{
    return bx_dateTimeStringWithFormatStyle(.medium, timeStyle: .medium)
  }
  
  public func bx_dateTimeStringWithFormatStyle(_ dateStyle:DateFormatter.Style,timeStyle:DateFormatter.Style) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle
    dateFormatter.timeStyle = timeStyle
    return dateFormatter.string(from: self)
  }
  
  public var bx_relativeDateTimeString:String{
    let secondsToNow = abs(Int(timeIntervalSinceNow))
    let now = Date()
    let calendar = Calendar.current
    switch secondsToNow{
    case 0..<60: return "刚刚"
    case 60..<300:
      return "\(secondsToNow / 60)分钟前"
    default:
      if calendar.isDateInYesterday(self){
        return "昨天 \(bx_shortTimeString)"
      }else if calendar.isDateInToday(self){
        return bx_shortTimeString
      }else if now.year == year{
        return bx_shortDateString
      }else{
        return self.bx_longDateString
      }
    }
    
  }
}
