//
//  OutlineButton.swift
//  SubjectEditorDemo
//
//  Created by Haizhen Lee on 15/6/3.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

public enum BXOutlineStyle:Int{
  case Rounded
  case Oval
  case Semicircle
}

public class OutlineButton: UIButton {
  
  public init(style:BXOutlineStyle = .Rounded){
    super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    outlineStyle = style
  }
  public var useTitleColorAsStrokeColor = true {
    didSet{
      updateOutlineColor()
    }
  }
  
  public var outlineColor:UIColor?{
    didSet{
      updateOutlineColor()
    }
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public var outlineStyle = BXOutlineStyle.Rounded{
    didSet{
      updateOutlinePath()
    }
  }
  
  public var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOutlinePath()
    }
  }
  
  public var lineWidth :CGFloat = 0.5 {
    didSet{
      outlineLayer.lineWidth = lineWidth
    }
  }
  
  
  
  public lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  public lazy var outlineLayer : CAShapeLayer = { [unowned self] in
    let outlineLayer = CAShapeLayer()
    outlineLayer.frame = self.frame
    outlineLayer.lineWidth = self.lineWidth
    outlineLayer.fillColor = UIColor.clearColor().CGColor
    outlineLayer.strokeColor = self.currentTitleColor.CGColor
    self.layer.addSublayer(outlineLayer)
    return outlineLayer
    }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    outlineLayer.frame = bounds
    updateOutlineColor()
    updateOutlinePath()
  }
  
  private func updateOutlinePath(){
    let path:UIBezierPath
    switch outlineStyle{
    case .Rounded:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    case .Oval:
      path = UIBezierPath(ovalInRect: bounds)
    case .Semicircle:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * 0.5)
    }
    maskLayer.path = path.CGPath
    outlineLayer.path = path.CGPath
  }
  
  private func updateOutlineColor(){
    if let color = outlineColor{
      outlineLayer.strokeColor = color.CGColor
    }else if useTitleColorAsStrokeColor{
      outlineLayer.strokeColor = currentTitleColor.CGColor
    }else{
      outlineLayer.strokeColor = tintColor.CGColor
    }
  }
  
  
  public override func tintColorDidChange() {
    super.tintColorDidChange()
    updateOutlineColor()
  }
  
}
