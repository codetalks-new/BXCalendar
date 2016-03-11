//
//  DateManager.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import UIKit

public class DateManager {
  public static let sharedManager = DateManager()
  var selectedDate = Set<Date>()
  
  
  public func contains(date:NSDate) -> Bool{
   return contains(Date(date: date))
  }
  
  public func contains(date:Date) -> Bool{
    return selectedDate.contains(date)
  }
  
  public func add(date:Date){
    selectedDate.insert(date)
  }
  
  public func add(date:NSDate){
    add(Date(date: date))
  }
  
  public func toggleAdd(date:Date){
    if selectedDate.contains(date){
      selectedDate.remove(date)
    }else{
      selectedDate.insert(date)
    }
  }
  
  public func toggleAdd(date:NSDate){
    toggleAdd(Date(date: date))
  }
  
  public func remove(date:Date){
    selectedDate.remove(date)
  }
  
  public func remove(date:NSDate){
    remove(Date(date: date))
  }
  
  public func removeAll(){
    selectedDate.removeAll()
  }
  
  public var dateSet:Set<Date>{
    return selectedDate
  }
  
  public var dateList:[NSDate]{
    var list = [NSDate]()
    for d in selectedDate{
      list.append(d.date)
    }
    return list
  }
  
  public var isEmpty:Bool{
    return selectedDate.isEmpty
  }
  
  public var count:Int{
    return selectedDate.count
  }
}

public struct Date{
  let year:Int
  let month:Int
  let day:Int
  
  public init(year:Int,month:Int,day:Int){
    self.year = year
    self.month = month
    self.day = day
  }
  
}

public extension Date{
  public var short_string:String{
    return "\(month)-\(day)"
  }
  public var long_string:String{
    return "\(year)-\(month)-\(day)"
  }
  
  // parse yyyy-MM-dd
  public static func parse(dateStr: String, format: String = "yyyy-MM-dd") -> Date {
    let dateFmt = NSDateFormatter()
    dateFmt.timeZone = NSTimeZone.defaultTimeZone()
    dateFmt.dateFormat = format
    let date =  dateFmt.dateFromString(dateStr)!
    return Date(date: date)
  }
}

extension Date{
  public init(date:NSDate){
    self.year = date.year
    self.month = date.month
    self.day = date.days
  }
}

extension Date{
  var date:NSDate{
    let comps = NSDateComponents()
    comps.year = year
    comps.month = month
    comps.day = day
    return calendar.dateFromComponents(comps)!
  }
}

extension Date:Equatable{
  
}

public func ==(lhs:Date,rhs:Date) -> Bool{
  return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}

extension Date:Hashable{
  public var hashValue:Int { return year * 1000 + month * 100 + day * 10 }
}