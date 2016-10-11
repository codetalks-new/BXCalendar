//
//  GroupButtonBar.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation
import UIKit

public enum GroupButtonBarAlignment:Int{
  case left
  case right
  case center
}

open class GroupButtonBar:UIView{
  
  open var buttonCount:Int{
    return buttons.count
  }
  
  open var buttonHeight:CGFloat = 33{
    didSet{
      setNeedsLayout()
    }
  }
  open var buttonWidth:CGFloat = 80{
    didSet{
      setNeedsLayout()
    }
  }
  open var buttonSpace:CGFloat = 10{
    didSet{
      setNeedsLayout()
    }
  }
  open var margin:CGFloat = 15{
    didSet{
      setNeedsLayout()
    }
  }
  open var alignment = GroupButtonBarAlignment.right{
    didSet{
      setNeedsLayout()
    }
  }
  
  open var onButtonClicked:((UIButton) -> Void)?
  
  fileprivate var buttons:[UIButton] = []
  
  open func appendButton(_ button:UIButton){
    self.buttons.append(button)
    onButtonListChanged()
  }
  
  open func appendButtons(_ buttons:[UIButton]){
    self.buttons.append(contentsOf: buttons)
    onButtonListChanged()
  }
  open func updateButtons(_ buttons:[UIButton]){
    for button in buttons{
      button.removeFromSuperview()
    }
    for button in self.buttons{
     button.removeFromSuperview()
    }
    self.buttons.removeAll()
    self.buttons.append(contentsOf: buttons)
    onButtonListChanged()
  }
  
  func onButtonListChanged(){
    setupButtons()
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  open func buttonAtIndex(_ index:Int) -> UIButton?{
    return ( index > -1 && index < buttons.count) ? buttons[index] : nil
  }
  
  open var firstButton:UIButton?{
    return buttonAtIndex(0)
  }
  
  open var secondButton:UIButton?{
    return buttonAtIndex(1)
  }
  
  open var thirdButton:UIButton?{
    return buttonAtIndex(2)
  }
  
  
  public init(
    buttons:[UIButton],
    alignment:GroupButtonBarAlignment = .right
    ){
    self.buttons = buttons
    self.alignment = alignment
    super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 54))
    setupButtons()
  }
  
  func setupButtons(){
    for button in buttons{
      button.removeFromSuperview()
      addSubview(button)
      button.addTarget(self, action: #selector(GroupButtonBar.onPressedButton(_:)), for: .touchUpInside)
    }
  }

  func onPressedButton(_ sender:UIButton){
    onButtonClicked?(sender)
  }
  
 public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    switch alignment{
    case .right:layoutButtonsAlignRight()
    case .left:layoutButtonsAlignLeft()
    case .center: layoutButtonsAlignCenter()
    }
    
  }
  
  fileprivate func layoutButtonsAlignCenter(){
    if buttons.isEmpty{
      return
    }
   
    var views = buttons
    var leftFrame = CGRect.zero
    var rightFrame = CGRect.zero
    
    let fullOffset = buttonWidth + buttonSpace
      let middleFrame = CGRect(center: bounds.center, width: buttonWidth, height: buttonHeight)
    // 奇数个先处理中间一个
    if views.count % 2 != 0{
       let middle = (views.count + 1) / 2 - 1
        let middleView = views.remove(at: middle)
        middleView.frame = middleFrame
        leftFrame = middleFrame.offsetBy(dx: -fullOffset, dy: 0)
        rightFrame = middleFrame.offsetBy(dx: fullOffset, dy: 0)
    }else{
        let offset = (buttonWidth + buttonSpace) * 0.5
        leftFrame = middleFrame.offsetBy(dx: -offset, dy: 0)
        rightFrame = middleFrame.offsetBy(dx: offset, dy: 0)
    }
    
    if views.isEmpty{
      return
    }
    
    while !views.isEmpty{
        let leftView = views.removeFirst()
        let rightView = views.removeLast()
        leftView.frame = leftFrame
        rightView.frame = rightFrame
        leftFrame = leftFrame.offsetBy(dx: -fullOffset, dy: 0)
        rightFrame = rightFrame.offsetBy(dx: fullOffset, dy: 0)
    }
    
    
  }
  
  fileprivate func layoutButtonsAlignLeft(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    var buttonFrame = CGRect(x: margin, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      
      buttonFrame = buttonFrame.offsetBy(dx: buttonWidth + buttonSpace, dy: 0)
    }
  }
  
  fileprivate func layoutButtonsAlignRight(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    let originX = bounds.maxX - margin - buttonWidth
    var buttonFrame = CGRect(x: originX, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      buttonFrame = buttonFrame.offsetBy(dx: -(buttonWidth + buttonSpace), dy: 0)
    }
  }
  
}
