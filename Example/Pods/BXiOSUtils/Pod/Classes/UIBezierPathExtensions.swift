//
//  UIBezierPathExtensions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/28.
//
//

import UIKit

public extension UIBezierPath{
  
  public convenience init(starInRect rect:CGRect){
    self.init()
    // 从上面的中间开始绘制
    let startPoint = CGPoint(x: rect.midX, y: rect.minY)
    let point1 = CGPoint(x: rect.minX + rect.width * 0.6763, y: rect.minY + rect.height * 0.2573)
    let point2 = CGPoint(x: rect.minX + rect.width * 0.9755, y: rect.minY + rect.height * 0.3455)
    let point3 = CGPoint(x: rect.minX + rect.width * 0.7853, y: rect.minY + rect.height * 0.5927)
    let point4 = CGPoint(x: rect.minX + rect.width * 0.7939, y: rect.minY + rect.height * 0.9045)
    let point5 = CGPoint(x: rect.minX + rect.width * 0.50, y: rect.minY + rect.height * 0.80)
    let point6 = CGPoint(x: rect.minX + rect.width * 0.2061, y: rect.minY + rect.height * 0.9045)
    let point7 = CGPoint(x: rect.minX + rect.width * 0.2147, y: rect.minY + rect.height * 0.5927)
    let point8 = CGPoint(x: rect.minX + rect.width * 0.0245, y: rect.minY + rect.height * 0.3455)
    let point9 = CGPoint(x: rect.minX + rect.width * 0.3237, y: rect.minY + rect.height * 0.2573)
    moveToPoint(startPoint)
    for point in [point1,point2,point3,point4,point5,point6,point7,point8,point9] {
      addLineToPoint(point)
    }
    closePath()
  }
}