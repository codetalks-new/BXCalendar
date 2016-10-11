//
//  OvalLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/29.
//
//

import UIKit

open class OvalLabel:UILabel{
  open var horizontalPadding:CGFloat = 4
  open var verticalPadding:CGFloat = 4
  
  open var outlineStyle = BXOutlineStyle.oval{
    didSet{
      updateOvalPath()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOvalPath()
    }
  }
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    updateOvalPath()
  }
  
  fileprivate func updateOvalPath(){
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
  
  open override var intrinsicContentSize : CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + horizontalPadding * 2, height: size.height + verticalPadding * 2)
  }
}
