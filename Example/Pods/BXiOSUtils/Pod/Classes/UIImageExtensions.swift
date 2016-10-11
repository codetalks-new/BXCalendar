//
//  UIImageExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension UIImage{
  
  
  
  public class func bx_image(_ hex:Int,alpha:Double=1.0) -> UIImage{
    return bx_image(UIColor(hex: hex, alpha: alpha))
  }
  
  public class func bx_transparentImage(_ size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clear.setFill()
    ctx?.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }
  
  
  public static func bx_circleImage(_ color:UIColor,radius:CGFloat) -> UIImage{
    let size = CGSize(width: radius * 2, height: radius * 2)
    let cornerRadius = radius
    return bx_roundImage(color, size: size, cornerRadius: cornerRadius)
  }
  
  public static func bx_roundImage(_ color:UIColor,size:CGSize=CGSize(width: 32, height: 32),cornerRadius:CGFloat = 4) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clear.setFill()
    ctx?.fill(rect)
    color.setFill()
    let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
    path.lineWidth  = 2
    path.fill()
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }
  
  public class func bx_image(_ color:UIColor,width:CGFloat) -> UIImage{
    return bx_image(color, size: CGSize(width: width, height: width))
  }
  
  public class func bx_image(_ color:UIColor,size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    let ctx = UIGraphicsGetCurrentContext()
    color.setFill()
    ctx?.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
  }
  
  @nonobjc
  public static func bx_placeholder(_ width:CGFloat) -> UIImage{
    return bx_placeholder(CGSize(width: width, height: width))
  }
  
  @nonobjc
  public static func bx_placeholder(_ size:CGSize) -> UIImage{
    return bx_image(UIColor.white, size: size)
  }
  
  
  
  /**
   diameter:直径
   **/
  public  func bx_circularImage(diameter:CGFloat, highlightedColor:UIColor? = nil) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
      UIGraphicsBeginImageContextWithOptions(frame.size, false,0.0)
      let ctx = UIGraphicsGetCurrentContext()
      ctx?.saveGState()
      let imgPath = UIBezierPath(ovalIn: frame)
      imgPath.addClip()
      draw(in: frame)
      if let color = highlightedColor{
        color.setFill()
        ctx?.fillEllipse(in: frame)
      }
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage!
      
  }
  
  public  func bx_highlightImage( _ highlightedColor:UIColor? = nil,circular:Bool=true) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: size.width , height: size.height )
      let color = highlightedColor ?? UIColor(white: 0.1, alpha: 0.3)
      UIGraphicsBeginImageContextWithOptions(frame.size, false,scale)
      let ctx = UIGraphicsGetCurrentContext()
      ctx?.saveGState()
      if circular{
        let imgPath = UIBezierPath(ovalIn: frame)
        imgPath.addClip()
      }else{
        let imgPath = UIBezierPath(roundedRect: frame, cornerRadius: 10)
        imgPath.addClip()
      }
      draw(in: frame)
      color.setFill()
      if circular{
        ctx?.fillEllipse(in: frame)
      }else{
        ctx?.fill(frame)
      }
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage!
  }
  
  public static func bx_createImage(_ text:String,backgroundColor:UIColor,
    textColor:UIColor,font:UIFont,diameter:CGFloat) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
      let attrs = [NSFontAttributeName:font,
        NSForegroundColorAttributeName:textColor
      ]
      let textFrame = text.boundingRect(with: frame.size, options:.usesFontLeading, attributes: attrs, context: nil)
      
      let dx = frame.midX - textFrame.midX
      let dy = frame.midY - textFrame.midY
      let drawPoint = CGPoint(x: dx, y: dy)
      UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
      let ctx = UIGraphicsGetCurrentContext()
      ctx?.saveGState()
      backgroundColor.setFill()
      ctx?.fill(frame)
      text.draw(at: drawPoint, withAttributes: attrs)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      ctx?.restoreGState()
      UIGraphicsEndImageContext()
      return image!
  }
  
  
}

public extension UIImage{
  public var bx_rawImage:UIImage{
    return self.withRenderingMode(.alwaysOriginal)
  }
}


