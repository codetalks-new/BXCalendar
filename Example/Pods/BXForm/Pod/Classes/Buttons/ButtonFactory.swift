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
    setBackgroundImage(UIImage.bx_image(FormColors.redColor), forState: .Normal)
    setBackgroundImage(FormButtons.lightGrayImage, forState: .Disabled)
    setTitleColor(UIColor.whiteColor(), forState: .Normal)
    setTitleColor(UIColor.whiteColor(), forState: .Disabled)
  }
  
  func setupAsAccentButton(){
    setBackgroundImage(FormButtons.accentImage, forState: .Normal)
    setBackgroundImage(FormButtons.lightGrayImage, forState: .Disabled)
    setTitleColor(UIColor.whiteColor(), forState: .Normal)
    setTitleColor(UIColor.whiteColor(), forState: .Disabled)
  }
  
  func setupAsPrimaryActionButton(){
    setBackgroundImage(FormButtons.primaryImage, forState: .Normal)
    setBackgroundImage(FormButtons.lightGrayImage, forState: .Disabled)
    setTitleColor(UIColor.whiteColor(), forState: .Normal)
    setTitleColor(UIColor.whiteColor(), forState: .Disabled)
  }
}

struct FormButtons{
  
  static func backgroundImage(color:UIColor) -> UIImage{
    let cornerRadius = FormMetrics.cornerRadius
    let size = CGSize(width: 64, height: 64)
    let image = UIImage.bx_roundImage(color, size: size, cornerRadius: cornerRadius)
    let buttonImage = image.resizableImageWithCapInsets(UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
    return buttonImage
  }
  
  static let accentImage = FormButtons.backgroundImage(FormColors.accentColor)
  static let primaryImage = FormButtons.backgroundImage(FormColors.accentColor)
  static let lightGrayImage = FormButtons.backgroundImage(FormColors.lightGrayColor)
  
}