//
//  UIImageExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension UIImage{
  
  
  
  public class func bx_image(hex:Int,alpha:Double=1.0) -> UIImage{
    return bx_image(UIColor(hex: hex, alpha: alpha))
  }
  
  public class func bx_transparentImage(size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clearColor().setFill()
    CGContextFillRect(ctx, rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
  }
  
  
  public static func bx_circleImage(color:UIColor,radius:CGFloat) -> UIImage{
    let size = CGSize(width: radius * 2, height: radius * 2)
    let cornerRadius = radius
    return bx_roundImage(color, size: size, cornerRadius: cornerRadius)
  }
  
  public static func bx_roundImage(color:UIColor,size:CGSize=CGSize(width: 32, height: 32),cornerRadius:CGFloat = 4) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    UIColor.clearColor().setFill()
    CGContextFillRect(ctx, rect)
    color.setFill()
    let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
    path.lineWidth  = 2
    path.fill()
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
  }
  
  public class func bx_image(color:UIColor,width:CGFloat) -> UIImage{
    return bx_image(color, size: CGSize(width: width, height: width))
  }
  
  public class func bx_image(color:UIColor,size:CGSize=CGSize(width: 1, height: 1)) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    let ctx = UIGraphicsGetCurrentContext()
    color.setFill()
    CGContextFillRect(ctx, rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
  }
  
  @nonobjc
  public static func bx_placeholder(width:CGFloat) -> UIImage{
    return bx_placeholder(CGSize(width: width, height: width))
  }
  
  @nonobjc
  public static func bx_placeholder(size:CGSize) -> UIImage{
    return bx_image(UIColor.whiteColor(), size: size)
  }
  
  
  
  /**
   diameter:直径
   **/
  public  func bx_circularImage(diameter diameter:CGFloat, highlightedColor:UIColor? = nil) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
      UIGraphicsBeginImageContextWithOptions(frame.size, false,0.0)
      let ctx = UIGraphicsGetCurrentContext()
      CGContextSaveGState(ctx)
      let imgPath = UIBezierPath(ovalInRect: frame)
      imgPath.addClip()
      drawInRect(frame)
      if let color = highlightedColor{
        color.setFill()
        CGContextFillEllipseInRect(ctx, frame)
      }
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
      
  }
  
  public  func bx_highlightImage( highlightedColor:UIColor? = nil,circular:Bool=true) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: size.width , height: size.height )
      let color = highlightedColor ?? UIColor(white: 0.1, alpha: 0.3)
      UIGraphicsBeginImageContextWithOptions(frame.size, false,scale)
      let ctx = UIGraphicsGetCurrentContext()
      CGContextSaveGState(ctx)
      if circular{
        let imgPath = UIBezierPath(ovalInRect: frame)
        imgPath.addClip()
      }else{
        let imgPath = UIBezierPath(roundedRect: frame, cornerRadius: 10)
        imgPath.addClip()
      }
      drawInRect(frame)
      color.setFill()
      if circular{
        CGContextFillEllipseInRect(ctx, frame)
      }else{
        CGContextFillRect(ctx, frame)
      }
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
  }
  
  public static func bx_createImage(text:String,backgroundColor:UIColor,
    textColor:UIColor,font:UIFont,diameter:CGFloat) -> UIImage {
      let frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
      let attrs = [NSFontAttributeName:font,
        NSForegroundColorAttributeName:textColor
      ]
      let textFrame = text.boundingRectWithSize(frame.size, options:.UsesFontLeading, attributes: attrs, context: nil)
      
      let dx = frame.midX - textFrame.midX
      let dy = frame.midY - textFrame.midY
      let drawPoint = CGPoint(x: dx, y: dy)
      UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
      let ctx = UIGraphicsGetCurrentContext()
      CGContextSaveGState(ctx)
      backgroundColor.setFill()
      CGContextFillRect(ctx, frame)
      text.drawAtPoint(drawPoint, withAttributes: attrs)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      CGContextRestoreGState(ctx)
      UIGraphicsEndImageContext()
      return image
  }
  
  
}