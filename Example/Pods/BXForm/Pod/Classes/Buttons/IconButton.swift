//
//  IconButton.swift
//
//  Created by Haizhen Lee on 15/11/10.
//

import UIKit

public class IconButton:UIButton{
  public var iconPadding = FormMetrics.iconPadding
  
  public var cornerRadius:CGFloat = 4.0 {
    didSet{
      setNeedsLayout()
    }
  }
  
  public var lineWidth :CGFloat = 0.5 {
    didSet{
      setNeedsLayout()
    }
  }
  
  lazy var maskLayer:CALayer = {
    let layer = CALayer()
    self.layer.mask = layer
    return layer
  }()
  
  
  public override func intrinsicContentSize() -> CGSize {
      let size = super.intrinsicContentSize()
      return CGSize(width: size.width + iconPadding, height: size.height)
  }
  
  public var icon:UIImage?{
    set{
      setImage(newValue, forState: .Normal)
      titleEdgeInsets = UIEdgeInsets(top: 0, left: newValue == nil ? 0: iconPadding, bottom: 0, right: 0)
      invalidateIntrinsicContentSize()
    }get{
      return imageForState(.Normal)
    }
  }
}
