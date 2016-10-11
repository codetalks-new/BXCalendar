//
//  CGRectExtentions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import Foundation
import UIKit

public extension CGSize{
  
  public func sizeByScaleToWidth(_ width:CGFloat) -> CGSize{
    let factor =  width / self.width
    let h = self.height * factor
    return CGSize(width: width, height: h)
  }
  
  public init(size:CGFloat){
    self.init(width:size,height:size)
  }
}

public extension CGRect{
  public func rectBySliceLeft(_ left:CGFloat) -> CGRect{
    return CGRect(x: origin.x + left, y: origin.y, width: width - left, height: height)
  }
  
  public func rectBySliceRight(_ right:CGFloat) -> CGRect{
    return CGRect(x: origin.x, y: origin.y, width: width - right, height: height)
  }
  
  public func rectBySliceTop(_ top:CGFloat) -> CGRect{
    return insetBy(dx: 0, dy: top)
  }
}

extension CGRect{
  public var center:CGPoint{
    get{
      return CGPoint(x: midX, y: midY)
    }
    set(newCenter){
      origin.x = newCenter.x - (width / 2)
      origin.y = newCenter.y - (height / 2 )
    }
  }
  
  public init(center:CGPoint,radius:CGFloat){
    origin = CGPoint(x: center.x - radius, y: center.y - radius)
    size = CGSize(width: radius * 2, height: radius * 2)
  }
  
  public init(center:CGPoint,width:CGFloat, height:CGFloat){
    origin = CGPoint(x: center.x - width * 0.5, y: center.y - height * 0.5)
    size = CGSize(width: width, height: height)
  }
  
  public init(center:CGPoint,size:CGSize){
    origin = CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
    self.size = size
  }
  public var area:CGFloat{
    return width * height
  }
}
