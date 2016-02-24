//
//  UIViewControllerExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit

public extension UIViewController{
  public func bx_promptNotAuthorized(message:String){
    let bundleNameKey = String(kCFBundleNameKey)
    let title = NSBundle.mainBundle().infoDictionary?[bundleNameKey] as? String ?? "提示"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    alert.addAction(UIAlertAction(title: "确定", style: .Cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "设置", style: .Default){
      action in
      UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
      })
    presentViewController(alert, animated: true, completion: nil)
  }
}

public extension UIViewController{
  public func bx_shareImageUsingSystemShare(image:UIImage,text:String=""){
    let controller = UIActivityViewController(activityItems: [image,text], applicationActivities: nil)
    self.presentViewController(controller, animated: true, completion: nil)
  }
}

public extension UIViewController{
  public func bx_closeSelf(){
    let poped = navigationController?.popViewControllerAnimated(true)
    if poped == nil{
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  public func bx_navUp(){
    navigationController?.popViewControllerAnimated(true)
  }
  
}

