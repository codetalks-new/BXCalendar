//
//  FoundationGlobals.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//
// Some code taken from https://github.com/ibireme/YYCategories/blob/master/YYCategories/UIKit/UIApplication%2BYYAdd.m

import Foundation

public func bx_documentURL() -> NSURL{
  return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
}

public func bx_cachesURL() -> NSURL{
  return NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).last!
}

public func bx_libraryURL() -> NSURL{
  return NSFileManager.defaultManager().URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).last!
}

public func bx_documentPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
}

public func bx_cachesPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
}

public func bx_libraryPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first!
}

public func bx_systemVersion() ->String{
  return UIDevice.currentDevice().systemVersion
}

public func bx_deviceModel() -> String{
  return UIDevice.currentDevice().model
}

public func bx_versionName() -> String{
  return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String ?? "Unkown"
}

public func bx_versionNumber() -> String{
  return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as? String ?? "0"
}

public func bx_appBundleName() -> String{
  return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String ?? "Unkown"
}

public func bx_appBundleIdentifir() -> String{
  return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as? String ?? "Unkown"
}