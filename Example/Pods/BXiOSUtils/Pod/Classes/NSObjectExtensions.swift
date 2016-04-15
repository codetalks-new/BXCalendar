//
//  NSObjectExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 16/4/7.
//
//

import Foundation

public extension NSObject{
  
  //
  // Swizzle 过的方法注意要在相应方法中调用同名方法.即原来应该调用的方法
  // func hook_viewWillDisappear(animated:Bool){
    // self.hook_viewWillDisappear(animated)
  // }
  //
  public class func bx_swapInstanceMethod(original:Selector,replacement:Selector){
    let originalMethod = class_getInstanceMethod(self, original)
    let replacementMethod = class_getInstanceMethod(self, replacement)
    let didAddMethod = class_addMethod(self, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))
    if didAddMethod{
      class_replaceMethod(self, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    }else{
      method_exchangeImplementations(originalMethod, replacementMethod)
    }
    
  }
  
  public class func bx_swapClassMethod(original:Selector,replacement:Selector){
    let originalMethod = class_getClassMethod(self, original)
    let replacementMethod = class_getClassMethod(self, replacement)
    let didAddMethod = class_addMethod(self, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod))
    if didAddMethod{
      class_replaceMethod(self, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    }else{
      method_exchangeImplementations(originalMethod, replacementMethod)
    }
    
  }
  
}

//
//
// Simulator 
//  with textLabel{
//      .textAlignment = .Center
//  }

public extension NSObjectProtocol{
  public func with(@noescape using: Self -> Void ) -> Self{
    using(self)
    return self
  }
}

public func with<T>(inout this:T, @noescape using:inout T -> Void){
  using(&this)
}

public func with<T>(this:T, @noescape using: T -> Void ){
  using(this)
}