//
//  OvalImageView.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/15.
//
//


import UIKit

public class OvalImageView: UIImageView {
  public lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(ovalInRect:bounds).CGPath
  }
  
}