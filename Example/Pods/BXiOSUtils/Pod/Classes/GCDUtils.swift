//
//  GCDUtils.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import Foundation

public func bx_async(_ block:@escaping ()->()){
  DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: block)
}

public func bx_async_utility(_ block:@escaping ()->()){
  DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async(execute: block)
}

public func bx_async_background(_ block:@escaping ()->()){
  DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: block)
}

public func bx_async_user_initiated(_ block:@escaping ()->()){
  DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async(execute: block)
}

public func bx_async_user_interactive(_ block:@escaping ()->()){
  DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async(execute: block)
}

public func bx_runInUiThread(_ block:@escaping ()->()){
  if Thread.isMainThread{
      block()
  }else{
    DispatchQueue.main.async(execute: block)
  }
}

public func bx_runInMainThread(_ block:@escaping ()->()){
  if Thread.isMainThread{
    block()
  }else{
    DispatchQueue.main.async(execute: block)
  }
}

// Delay in main
public func bx_delay(_ delay:TimeInterval,block:@escaping ()->()){
  DispatchQueue.main.asyncAfter(
    deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    , execute: block)
}

public func bx_local(_ closure:() -> Void){
  closure()
}

/**
@available(iOS 8.0, *)
public var QOS_CLASS_USER_INTERACTIVE: qos_class_t { get }

@available(iOS 8.0, *)
public var QOS_CLASS_USER_INITIATED: qos_class_t { get }

@available(iOS 8.0, *)
public var QOS_CLASS_DEFAULT: qos_class_t { get }

@available(iOS 8.0, *)
public var QOS_CLASS_UTILITY: qos_class_t { get }

@available(iOS 8.0, iOS 8.0, *)
public var QOS_CLASS_BACKGROUND: qos_class_t { get }

@available(iOS 8.0, *)
public var QOS_CLASS_UNSPECIFIED: qos_class_t { get }
**/
