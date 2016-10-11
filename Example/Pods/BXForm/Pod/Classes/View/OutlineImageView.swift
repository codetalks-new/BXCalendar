//
//  OutlineImageView.swift
//
//  Created by Haizhen Lee on 15/12/25.
//

import UIKit

open class OutlineImageView:UIImageView{

  open var borderColor:UIColor = UIColor(hex: 0xe0e0e0){
    didSet{
      layer.borderColor = borderColor.cgColor
    }
  }
  
  open var borderWidth:CGFloat = 0.5{
    didSet{
      layer.borderWidth = borderWidth
    }
  }
  
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
    clipsToBounds = true
  }
}
