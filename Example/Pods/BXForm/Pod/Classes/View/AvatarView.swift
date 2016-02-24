//
//  AvatarView.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/15.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit


public class AvatarView:UIView{
 
  public lazy var avatarImageView: OvalImageView = {
    let view = OvalImageView(frame: CGRectZero)
    self.addSubview(view)
    return view
  }()
  
  public var borderWidth:CGFloat = 2.0{
    didSet{
      updateBorderStyle()
    }
  }
  
  public var borderColor:UIColor=UIColor(white: 1.0, alpha: 0.45){
    didSet{
      updateBorderStyle()
    }
  }
  
  
  
  public func updateBorderStyle(){
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.CGColor
  }
  
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.width * 0.5
    avatarImageView.frame = bounds.insetBy(dx: borderWidth, dy: borderWidth)
  }
  
  
  
  
}