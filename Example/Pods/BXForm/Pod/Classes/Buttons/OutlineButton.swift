//
//  OutlineButton.swift
//  SubjectEditorDemo
//
//  Created by Haizhen Lee on 15/6/3.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

public enum BXOutlineStyle:Int{
  case rounded
  case oval
  case semicircle
}

open class OutlineButton: UIButton {
  
  public init(style:BXOutlineStyle = .rounded){
    super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    outlineStyle = style
  }
  open var useTitleColorAsStrokeColor = true {
    didSet{
      updateOutlineColor()
    }
  }
  
  open var outlineColor:UIColor?{
    didSet{
      updateOutlineColor()
    }
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open var outlineStyle = BXOutlineStyle.rounded{
    didSet{
      updateOutlinePath()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOutlinePath()
    }
  }
  
  open var lineWidth :CGFloat = 0.5 {
    didSet{
      outlineLayer.lineWidth = lineWidth
    }
  }
  
  
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open lazy var outlineLayer : CAShapeLayer = { [unowned self] in
    let outlineLayer = CAShapeLayer()
    outlineLayer.frame = self.frame
    outlineLayer.lineWidth = self.lineWidth
    outlineLayer.fillColor = UIColor.clear.cgColor
    outlineLayer.strokeColor = self.currentTitleColor.cgColor
    self.layer.addSublayer(outlineLayer)
    return outlineLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    outlineLayer.frame = bounds
    updateOutlineColor()
    updateOutlinePath()
  }
  
  fileprivate func updateOutlinePath(){
    let path:UIBezierPath
    switch outlineStyle{
    case .rounded:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    case .oval:
      path = UIBezierPath(ovalIn: bounds)
    case .semicircle:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * 0.5)
    }
    maskLayer.path = path.cgPath
    outlineLayer.path = path.cgPath
  }
  
  fileprivate func updateOutlineColor(){
    if let color = outlineColor{
      outlineLayer.strokeColor = color.cgColor
    }else if useTitleColorAsStrokeColor{
      outlineLayer.strokeColor = currentTitleColor.cgColor
    }else{
      outlineLayer.strokeColor = tintColor.cgColor
    }
  }
  
  
  open override func tintColorDidChange() {
    super.tintColorDidChange()
    updateOutlineColor()
  }
  
}
