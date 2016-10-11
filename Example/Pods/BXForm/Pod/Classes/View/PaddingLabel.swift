//
//  PaddingLabel.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/4/11.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import Foundation

open class PaddingLabel:UILabel{
  open var horizontalPadding:CGFloat = 4
  open var verticalPadding: CGFloat = 4
  
  open override var intrinsicContentSize : CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + horizontalPadding * 2, height: size.height + verticalPadding*2)
  }
}
