//
//  UIColorExtentions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension UIColor{
  
  public convenience init?(hexString:String){
    if hexString.isEmpty{
      return nil
    }
    let scanner = NSScanner(string:hexString)
    scanner.scanLocation = 1 // by pass first '#' char
    var rgbValue:UInt32 = 0
    scanner.scanHexInt(&rgbValue)
    self.init(hex:Int(rgbValue))
  }
  
  public convenience init(hex:Int,alpha:Double=1.0){
    let red = Double(( hex >> 16 ) & 0xff) / 255.0
    let green = Double(( hex >> 8) & 0xff)  / 255.0
    let blue = Double( hex & 0xff ) / 255.0
    self.init(red:CGFloat(red),green:CGFloat(green),blue:CGFloat(blue),alpha:CGFloat(alpha))
  }
  
  public var toInt:Int{
    var r:CGFloat = 0, g :CGFloat = 0, b :CGFloat = 0,a:CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let red = Int( r * 255.0 ) << 16
    let green = Int( g * 255.0 ) << 8
    let blue = Int(b * 255.0)
    return red + green + blue
  }
  
}
