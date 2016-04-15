//
//  TagLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/25.
//
//

import Foundation

//
//  OvalLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/29.
//
//

import UIKit

public class TagLabel:UILabel{
  public var horizontalPadding:CGFloat = 4
  
  public var outlineStyle = BXOutlineStyle.Oval{
    didSet{
      updateOvalPath()
    }
  }
  
  public var tagColor:UIColor = UIColor.grayColor(){
    didSet{
      updateOvalPath()
    }
  }
  
  public var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOvalPath()
    }
  }
  
  lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.insertSublayer(maskLayer,atIndex:0)
    return maskLayer
    }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    updateOvalPath()
  }
  
  private func updateOvalPath(){
    if bounds.size.width < 1{
      return
    }
    var radius:CGFloat
    switch outlineStyle{
    case .Rounded:
      radius = cornerRadius
    case .Oval:
      radius = bounds.width * 0.5
    case .Semicircle:
      radius = bounds.width * 0.5
    }
    
    let image = UIImage.bx_roundImage(tagColor, size: bounds.size, cornerRadius: radius)
    maskLayer.contents = image.CGImage
  }
  
  public override func intrinsicContentSize() -> CGSize {
    let size = super.intrinsicContentSize()
    return CGSize(width: size.width + horizontalPadding, height: size.height + horizontalPadding)
  }
}