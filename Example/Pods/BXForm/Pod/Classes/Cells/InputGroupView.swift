//
//  InputCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/1/7.
//
//

import Foundation

// Build for target uimodel
//locale (None, None)
import UIKit
import SwiftyJSON
import BXModel
import BXiOSUtils

// -InputView:v
// _[l15,y,r15,r0]:f
// span[w115,ver0,r0]:b

public class InputGroupView : UIView{
  public let textField = UITextField(frame:CGRectZero)
  public let spanButton = UIButton(type:.Custom)
  
  public var showSpanButton:Bool = true{
    didSet{
      spanButton.hidden = !showSpanButton
      relayout()
    }
  }
 
  public var showSpanDivider:Bool = true{
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var spanDividerColor:UIColor = UIColor(white: 0.937, alpha: 1.0){
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var spanDividerLineWidth:CGFloat = 1.0{
    didSet{
      setNeedsDisplay()
    }
  }
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [textField,spanButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [spanButton]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [textField]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    installChildViews()
    installConstaints()
    setupAttrs()
    
  }
  
  func relayout(){
    for childView in allOutlets{
      childView.removeFromSuperview()
    }
    installChildViews()
    installConstaints()
  }
  
  func installChildViews(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  func installConstaints(){
    textField.pinCenterY()
    textField.pinLeading(15)
    
    if showSpanButton{
      textField.pinTrailingToSibing(spanButton, margin: 4)
      
      spanButton.pinTrailing(0)
      spanButton.pinVertical(0)
      spanButton.pinWidth(115)
    }else{
      textField.pinTrailing(15)
    }
    
  }
  
  public func setupAttrs(){
    backgroundColor = .whiteColor()
  }
  
  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    if showSpanButton && showSpanDivider{
      let ctx = UIGraphicsGetCurrentContext()
      let startX  = spanButton.frame.minX
      spanDividerColor.setStroke()
      CGContextMoveToPoint(ctx, startX, rect.minY)
      CGContextAddLineToPoint(ctx, startX, rect.maxY)
      CGContextStrokePath(ctx)
    }
    
  }
}
