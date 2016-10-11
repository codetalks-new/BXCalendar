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

open class InputGroupView : UIView{
  open let textField = UITextField(frame:CGRect.zero)
  open let spanButton = UIButton(type:.custom)
  
  open var showSpanButton:Bool = true{
    didSet{
      spanButton.isHidden = !showSpanButton
      relayout()
    }
  }
 
  open var showSpanDivider:Bool = true{
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var spanDividerColor:UIColor = UIColor(white: 0.937, alpha: 1.0){
    didSet{
      setNeedsDisplay()
    }
  }
  
  open var spanDividerLineWidth:CGFloat = 1.0{
    didSet{
      setNeedsDisplay()
    }
  }
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  open override func awakeFromNib() {
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
    textField.pa_centerY.install()
    textField.pa_leading.eq(15).install()
    
    if showSpanButton{
      textField.pa_before(spanButton, offset: 4).install()
      
      spanButton.pa_trailing.eq(0).install()
      spanButton.pac_vertical(0)
      spanButton.pa_width.eq(115).install()
    }else{
      textField.pa_trailing.eq(15).install()
    }
    
  }
  
  open func setupAttrs(){
    backgroundColor = .white
  }
  
  open override func draw(_ rect: CGRect) {
    super.draw(rect)
    if showSpanButton && showSpanDivider{
      let ctx = UIGraphicsGetCurrentContext()
      let startX  = spanButton.frame.minX
      spanDividerColor.setStroke()
      ctx?.move(to: CGPoint(x: startX, y: rect.minY))
      ctx?.addLine(to: CGPoint(x: startX, y: rect.maxY))
      ctx?.strokePath()
    }
    
  }
}
