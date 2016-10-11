//
//  AttributedTextFactory.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

public struct AttributedText{
  public var textColor:UIColor
  public var font:UIFont
  public fileprivate(set) var text:String
  public init(text:String,font:UIFont = UIFont.systemFont(ofSize: 15),textColor:UIColor = UIColor.darkText){
    self.text = text
    self.font = font
    self.textColor = textColor
  }
  
  
  public var attributedText:NSAttributedString{
    return NSAttributedString(string: text, attributes: [NSFontAttributeName:font,NSForegroundColorAttributeName:textColor])
  }
}




public struct TextFactory{
  public static func createAttributedText(_ textAttributes:[AttributedText]) -> NSAttributedString{
    let attributedText = NSMutableAttributedString()
    for attr in textAttributes{
      attributedText.append(attr.attributedText)
    }
    return attributedText
  }
  

  
}
