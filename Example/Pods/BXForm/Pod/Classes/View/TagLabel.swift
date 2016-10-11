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

open class TagLabel:UILabel{
  open var horizontalPadding:CGFloat = 4
  
  open var outlineStyle = BXOutlineStyle.oval{
    didSet{
      updateOvalPath()
    }
  }
  
  open var tagColor:UIColor = UIColor.gray{
    didSet{
      updateOvalPath()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOvalPath()
    }
  }
  
  lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.insertSublayer(maskLayer,at:0)
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    updateOvalPath()
  }
  
  fileprivate func updateOvalPath(){
    if bounds.size.width < 1{
      return
    }
    var radius:CGFloat
    switch outlineStyle{
    case .rounded:
      radius = cornerRadius
    case .oval:
      radius = bounds.width * 0.5
    case .semicircle:
      radius = bounds.width * 0.5
    }
    
    let image = UIImage.bx_roundImage(tagColor, size: bounds.size, cornerRadius: radius)
    maskLayer.contents = image.cgImage
  }
  
  open override var intrinsicContentSize : CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + horizontalPadding, height: size.height + horizontalPadding)
  }
}
