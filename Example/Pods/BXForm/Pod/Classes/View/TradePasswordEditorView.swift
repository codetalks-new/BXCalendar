//
//  TradePasswordEditorView.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/6.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import Foundation

class PasswordPlaceholderView:UIView{
  var placeholderColor = UIColor.black{
    didSet{
      setNeedsDisplay()
    }
  }
  
  var placeholderRadius:CGFloat = 10.0 {
    didSet{
      setNeedsDisplay()
    }
  }
  
  override var intrinsicContentSize : CGSize {
    return CGSize(size: placeholderRadius * 2)
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let ovalRect = CGRect(center: rect.center, radius: placeholderRadius)
    let path = UIBezierPath(ovalIn: ovalRect)
    placeholderColor.setFill()
    path.fill()
  }
}

import UIKit
import BXModel
import BXiOSUtils


open class NumberPasswordEditorView : UIView,UITextFieldDelegate{
  let hiddenTextField = UITextField(frame:CGRect.zero)
  let passwordNumbersView = GridView()
  let passwordNumberCount:Int
  let passwordNumberPlaceholders:[PasswordPlaceholderView]
  
  public init(passwordNumberCount:Int=6){
    self.passwordNumberCount = passwordNumberCount
    self.passwordNumberPlaceholders = (1...passwordNumberCount).map{ _ in PasswordPlaceholderView() }
    for holder in self.passwordNumberPlaceholders{
      holder.backgroundColor = .white
      holder.placeholderRadius = 4
      holder.isHidden = true
    }
    hiddenTextField.text = ""
    super.init(frame: CGRect.zero)
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
  
  open func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  open func installConstaints(){
    passwordNumbersView.pac_edge(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    
    hiddenTextField.pa_centerY.install()
    hiddenTextField.pa_centerX.install()
    hiddenTextField.pac_horizontal()
    hiddenTextField.pa_height.eq(36).install()
    
  }
  
  open func setupAttrs(){
    hiddenTextField.delegate = self
    hiddenTextField.keyboardType = .numberPad
    hiddenTextField.addTarget(self, action: #selector(NumberPasswordEditorView.onTextChanged(_:)), for: .editingChanged)
    hiddenTextField.isSecureTextEntry = true // 就算不可见也要设置,因为 UITextField 有全局广播通知
    passwordNumbersView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NumberPasswordEditorView.onTap(_:))))
    layer.cornerRadius = 4
    clipsToBounds = true
  }
  
  
  
  func onTap(_ sender:AnyObject){
    hiddenTextField.becomeFirstResponder()
  }
  
  open override var canBecomeFirstResponder : Bool {
    return hiddenTextField.canBecomeFirstResponder
  }
  
  open override func becomeFirstResponder() -> Bool {
    return hiddenTextField.becomeFirstResponder()
  }
  
  open override func resignFirstResponder() -> Bool {
    return hiddenTextField.resignFirstResponder()
  }
  
  // MARK: UITextFieldDelegate
  
  func updateVisiblePasswordPlacehoders(){
    let numberCount = (hiddenTextField.text ?? "").characters.count
    var count = 0
    for placehoder in passwordNumberPlaceholders{
      placehoder.isHidden = count >= numberCount
      count += 1
    }
  }
  
  open var didInputAllPasswordNumberBlock:((String) -> Void)?
  
  func onTextChanged(_ sender:AnyObject){
    updateVisiblePasswordPlacehoders()
    if password.characters.count == 6{
      self.didInputAllPasswordNumberBlock?(password)
    }
  }
  
  open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
