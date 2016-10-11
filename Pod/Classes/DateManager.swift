//
//  DateManager.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import UIKit

open class DateManager {
  open static let sharedManager = DateManager()
  var selectedDate = Set<YMDDate>()
  
  
  open func contains(_ date:Foundation.Date) -> Bool{
   return contains(YMDDate(date: date))
  }
  
  open func contains(_ date:YMDDate) -> Bool{
    return selectedDate.contains(date)
  }
  
  open func add(_ date:YMDDate){
    selectedDate.insert(date)
  }
  
  open func add(_ date:Foundation.Date){
    add(YMDDate(date: date))
  }
  
  open func toggleAdd(_ date:YMDDate){
    if selectedDate.contains(date){
      selectedDate.remove(date)
    }else{
      selectedDate.insert(date)
    }
  }
  
  open func toggleAdd(_ date:Foundation.Date){
    toggleAdd(YMDDate(date: date))
  }
  
  open func remove(_ date:YMDDate){
    selectedDate.remove(date)
  }
  
  open func remove(_ date:Foundation.Date){
    remove(YMDDate(date: date))
  }
  
  open func removeAll(){
    selectedDate.removeAll()
  }
  
  open var dateSet:Set<YMDDate>{
    return selectedDate
  }
  
  open var dateList:[Date]{
    var list = [Date]()
    for d in selectedDate{
      list.append(d.date)
    }
    return list
  }
  
  open var isEmpty:Bool{
    return selectedDate.isEmpty
  }
  
  open var count:Int{
    return selectedDate.count
  }
}

public struct YMDDate{
  let year:Int
  let month:Int
  let day:Int
  
  public init(year:Int,month:Int,day:Int){
    self.year = year
    self.month = month
    self.day = day
  }
  
}

public extension YMDDate{
  public var short_string:String{
    return "\(month)-\(day)"
  }
  public var long_string:String{
    return "\(year)-\(month)-\(day)"
  }
  
  // parse yyyy-MM-dd
  public static func parse(_ dateStr: String, format: String = "yyyy-MM-dd") -> YMDDate {
    let dateFmt = DateFormatter()
    dateFmt.timeZone = TimeZone.current
    dateFmt.dateFormat = format
    let date =  dateFmt.date(from: dateStr)!
    return YMDDate(date: date)
  }
}

extension YMDDate{
  public init(date:Foundation.Date){
    self.year = date.year
    self.month = date.month
    self.day = date.days
  }
}

extension YMDDate{
  var date:Foundation.Date{
    var comps = DateComponents()
    comps.year = year
    comps.month = month
    comps.day = day
    return calendar.date(from: comps)!
  }
}

extension YMDDate:Equatable{
  
}

public func ==(lhs:YMDDate,rhs:YMDDate) -> Bool{
  return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}

extension YMDDate:Hashable{
  public var hashValue:Int { return year * 1000 + month * 100 + day * 10 }
}
