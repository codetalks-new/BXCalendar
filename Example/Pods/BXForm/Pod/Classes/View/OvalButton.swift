//
//  OvalButton.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/29.
//
//


import UIKit

open class OvalButton:UIButton{
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
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
  }
  
  
  open var outlineStyle = BXOutlineStyle.oval{
    didSet{
      updateOutlinePath()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOutlinePath()
    }
  }
}
