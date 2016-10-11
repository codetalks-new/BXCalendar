//
//  OvalImageView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/15.
//
//


import UIKit

open class OvalImageView: UIImageView {
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(ovalIn:bounds).cgPath
  }
  
}
