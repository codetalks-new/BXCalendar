//
//  AvatarView.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/15.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit


open class AvatarView:UIView{
 
  open lazy var avatarImageView: OvalImageView = {
    let view = OvalImageView(frame: CGRect.zero)
    self.addSubview(view)
    return view
  }()
  
  open var borderWidth:CGFloat = 2.0{
    didSet{
      updateBorderStyle()
    }
  }
  
  open var borderColor:UIColor=UIColor(white: 1.0, alpha: 0.45){
    didSet{
      updateBorderStyle()
    }
  }
  
  
  
  open func updateBorderStyle(){
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }
  
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.width * 0.5
    avatarImageView.frame = bounds.insetBy(dx: borderWidth, dy: borderWidth)
  }
  
  
  
  
}
