//
//  GCDUtils.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import Foundation

public func bx_async(block:dispatch_block_t){
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), block)
}

public func bx_async_utility(block:dispatch_block_t){
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), block)
}

public func bx_async_background(block:dispatch_block_t){
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), block)
}

public func bx_async_user_initiated(block:dispatch_block_t){
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), block)
}

public func bx_async_user_interactive(block:dispatch_block_t){
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), block)
}

public func bx_runInUiThread(block:dispatch_block_t){
  if NSThread.isMainThread(){
      block()
  }else{
    dispatch_async(dispatch_get_main_queue(), block)
  }
}

public func bx_runInMainThread(block:dispatch_block_t){
  if NSThread.isMainThread(){
    block()
  }else{
    dispatch_async(dispatch_get_main_queue(), block)
  }
}

// Delay in main
public func bx_delay(delay:NSTimeInterval,block:dispatch_block_t){
  dispatch_after(
    dispatch_time(DISPATCH_TIME_NOW,Int64(delay * Double(NSEC_PER_SEC)))
    , dispatch_get_main_queue()
    , block)
}

public func bx_local(closure:() -> Void){
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