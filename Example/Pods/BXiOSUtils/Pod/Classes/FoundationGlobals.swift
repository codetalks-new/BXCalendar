//
//  FoundationGlobals.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//
// Some code taken from https://github.com/ibireme/YYCategories/blob/master/YYCategories/UIKit/UIApplication%2BYYAdd.m

import Foundation

public func bx_documentURL() -> URL{
  return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

public func bx_cachesURL() -> URL{
  return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
}

public func bx_libraryURL() -> URL{
  return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
}

public func bx_documentPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
}

public func bx_cachesPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
}

public func bx_libraryPath() -> String{
  return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
}

public func bx_systemVersion() ->String{
  return UIDevice.current.systemVersion
}

public func bx_deviceModel() -> String{
  return UIDevice.current.model
}

public func bx_versionName() -> String{
  return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unkown"
}

public func bx_versionNumber() -> String{
  return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
}

public func bx_appBundleName() -> String{
  return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unkown"
}

public func bx_appBundleIdentifir() -> String{
  return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? "Unkown"
}
