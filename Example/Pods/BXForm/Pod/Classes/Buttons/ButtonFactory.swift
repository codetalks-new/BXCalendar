//
//  ButtonFactory.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

import UIKit
import BXiOSUtils

extension UIButton{
  
  func setupAsRedButton(){
    setBackgroundImage(UIImage.bx_image(FormColors.redColor), for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  func setupAsAccentButton(){
    setBackgroundImage(FormButtons.accentImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
  
  func setupAsPrimaryActionButton(){
    setBackgroundImage(FormButtons.primaryImage, for: .normal)
    setBackgroundImage(FormButtons.lightGrayImage, for: .disabled)
    setTitleColor(UIColor.white, for: UIControlState())
    setTitleColor(UIColor.white, for: .disabled)
  }
}

struct FormButtons{
  
  static func backgroundImage(_ color:UIColor) -> UIImage{
    let cornerRadius = FormMetrics.cornerRadius
    let size = CGSize(width: 64, height: 64)
    let image = UIImage.bx_roundImage(color, size: size, cornerRadius: cornerRadius)
    let buttonImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    return buttonImage
  }
  
  static let accentImage = FormButtons.backgroundImage(FormColors.accentColor)
  static let primaryImage = FormButtons.backgroundImage(FormColors.accentColor)
  static let lightGrayImage = FormButtons.backgroundImage(FormColors.lightGrayColor)
  
}
