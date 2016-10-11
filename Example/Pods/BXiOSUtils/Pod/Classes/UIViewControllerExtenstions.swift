//
//  UIViewControllerExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit

public extension UIViewController{
  public func bx_promptNotAuthorized(_ message:String){
    let bundleNameKey = String(kCFBundleNameKey)
    let title = Bundle.main.infoDictionary?[bundleNameKey] as? String ?? "提示"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "设置", style: .default){
      action in
      UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
      })
    present(alert, animated: true, completion: nil)
  }
}

public extension UIViewController{
  public func bx_shareImageUsingSystemShare(_ image:UIImage,text:String=""){
    let controller = UIActivityViewController(activityItems: [image,text], applicationActivities: nil)
    self.present(controller, animated: true, completion: nil)
  }
}

public extension UIViewController{
  public func bx_closeSelf(){
    let poped = navigationController?.popViewController(animated: true)
    if poped == nil{
      dismiss(animated: true, completion: nil)
    }
  }
  
  public func bx_navUp(){
    navigationController?.popViewController(animated: true)
  }
  
}

