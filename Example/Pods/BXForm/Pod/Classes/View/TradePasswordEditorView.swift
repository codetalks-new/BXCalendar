//
//  TradePasswordEditorView.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/6.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import Foundation

class PasswordPlaceholderView:UIView{
  var placeholderColor = UIColor.blackColor(){
    didSet{
      setNeedsDisplay()
    }
  }
  
  var placeholderRadius:CGFloat = 10.0 {
    didSet{
      setNeedsDisplay()
    }
  }
  
  override func intrinsicContentSize() -> CGSize {
    return CGSize(size: placeholderRadius * 2)
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    let ovalRect = CGRect(center: rect.center, radius: placeholderRadius)
    let path = UIBezierPath(ovalInRect: ovalRect)
    placeholderColor.setFill()
    path.fill()
  }
}

import UIKit
import BXModel
import BXiOSUtils


public class NumberPasswordEditorView : UIView,UITextFieldDelegate{
  let hiddenTextField = UITextField(frame:CGRectZero)
  let passwordNumbersView = GridView()
  let passwordNumberCount:Int
  let passwordNumberPlaceholders:[PasswordPlaceholderView]
  
  public init(passwordNumberCount:Int=6){
    self.passwordNumberCount = passwordNumberCount
    self.passwordNumberPlaceholders = (1...passwordNumberCount).map{ _ in PasswordPlaceholderView() }
    for holder in self.passwordNumberPlaceholders{
      holder.backgroundColor = .whiteColor()
      holder.placeholderRadius = 4
      holder.hidden = true
    }
    hiddenTextField.text = ""
    super.init(frame: CGRectZero)
    passwordNumbersView.showDividerMiddle = true
    passwordNumbersView.updateChildViews(passwordNumberPlaceholders)
    
    commonInit()
  }
  
  var password:String{
    return hiddenTextField.text ?? ""
  }
  
  var allOutlets :[UIView]{
    return [hiddenTextField,passwordNumbersView]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [hiddenTextField]
  }
  var allUIViewOutlets :[UIView]{
    return [passwordNumbersView]
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("NotImplemented")
  }
  
  public func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    passwordNumbersView.pac_edge(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    hiddenTextField.pa_centerY.install()
    hiddenTextField.pa_centerX.install()
    hiddenTextField.pac_horizontal()
    hiddenTextField.pa_height.eq(36).install()
    
  }
  
  public func setupAttrs(){
    hiddenTextField.delegate = self
    hiddenTextField.keyboardType = .NumberPad
    hiddenTextField.addTarget(self, action: #selector(NumberPasswordEditorView.onTextChanged(_:)), forControlEvents: .EditingChanged)
    hiddenTextField.secureTextEntry = true // 就算不可见也要设置,因为 UITextField 有全局广播通知
    passwordNumbersView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NumberPasswordEditorView.onTap(_:))))
    layer.cornerRadius = 4
    clipsToBounds = true
  }
  
  
  
  func onTap(sender:AnyObject){
    hiddenTextField.becomeFirstResponder()
  }
  
  public override func canBecomeFirstResponder() -> Bool {
    return hiddenTextField.canBecomeFirstResponder()
  }
  
  public override func becomeFirstResponder() -> Bool {
    return hiddenTextField.becomeFirstResponder()
  }
  
  public override func resignFirstResponder() -> Bool {
    return hiddenTextField.resignFirstResponder()
  }
  
  // MARK: UITextFieldDelegate
  
  func updateVisiblePasswordPlacehoders(){
    let numberCount = (hiddenTextField.text ?? "").characters.count
    var count = 0
    for placehoder in passwordNumberPlaceholders{
      placehoder.hidden = count >= numberCount
      count += 1
    }
  }
  
  public var didInputAllPasswordNumberBlock:(String -> Void)?
  
  func onTextChanged(sender:AnyObject){
    updateVisiblePasswordPlacehoders()
    if password.characters.count == 6{
      self.didInputAllPasswordNumberBlock?(password)
    }
  }
  
  public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    NSLog("\(#function) \(range) \(string)")
    let password = textField.text ?? ""
    let currentCount = password.characters.count
    if range.length == 0 {
      // append
      return currentCount < passwordNumberCount
    }else{
      // delete
      return true
    }
  }
  
}
