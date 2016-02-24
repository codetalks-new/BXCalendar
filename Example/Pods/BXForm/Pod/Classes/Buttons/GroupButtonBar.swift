//
//  GroupButtonBar.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

public enum GroupButtonBarAlignment:Int{
  case Left
  case Right
  case Center
}

public class GroupButtonBar:UIView{
  
  public var buttonCount:Int{
    return buttons.count
  }
  
  public var buttonHeight:CGFloat = 33{
    didSet{
      setNeedsLayout()
    }
  }
  public var buttonWidth:CGFloat = 80{
    didSet{
      setNeedsLayout()
    }
  }
  public var buttonSpace:CGFloat = 10{
    didSet{
      setNeedsLayout()
    }
  }
  public var margin:CGFloat = 15{
    didSet{
      setNeedsLayout()
    }
  }
  public var alignment = GroupButtonBarAlignment.Right{
    didSet{
      setNeedsLayout()
    }
  }
  
  public var onButtonClicked:(UIButton -> Void)?
  
  private var buttons:[UIButton] = []
  
  public func appendButton(button:UIButton){
    self.buttons.append(button)
    onButtonListChanged()
  }
  
  public func appendButtons(buttons:[UIButton]){
    self.buttons.appendContentsOf(buttons)
    onButtonListChanged()
  }
  public func updateButtons(buttons:[UIButton]){
    for button in buttons{
      button.removeFromSuperview()
    }
    for button in self.buttons{
     button.removeFromSuperview()
    }
    self.buttons.removeAll()
    self.buttons.appendContentsOf(buttons)
    onButtonListChanged()
  }
  
  func onButtonListChanged(){
    setupButtons()
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  public func buttonAtIndex(index:Int) -> UIButton?{
    return ( index > -1 && index < buttons.count) ? buttons[index] : nil
  }
  
  public var firstButton:UIButton?{
    return buttonAtIndex(0)
  }
  
  public var secondButton:UIButton?{
    return buttonAtIndex(1)
  }
  
  public var thirdButton:UIButton?{
    return buttonAtIndex(2)
  }
  
  
  public init(
    buttons:[UIButton],
    alignment:GroupButtonBarAlignment = .Right
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
      button.addTarget(self, action: "onPressedButton:", forControlEvents: .TouchUpInside)
    }
  }

  func onPressedButton(sender:UIButton){
    onButtonClicked?(sender)
  }
  
 public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    switch alignment{
    case .Right:layoutButtonsAlignRight()
    case .Left:layoutButtonsAlignLeft()
    case .Center: layoutButtonsAlignCenter()
    }
    
  }
  
  private func layoutButtonsAlignCenter(){
    if buttons.isEmpty{
      return
    }
   
    var views = buttons
    var leftFrame = CGRectZero
    var rightFrame = CGRectZero
    
    let fullOffset = buttonWidth + buttonSpace
      let middleFrame = CGRect(center: bounds.center, width: buttonWidth, height: buttonHeight)
    // 奇数个先处理中间一个
    if views.count % 2 != 0{
       let middle = (views.count + 1) / 2 - 1
        let middleView = views.removeAtIndex(middle)
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
  
  private func layoutButtonsAlignLeft(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    var buttonFrame = CGRect(x: margin, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      buttonFrame.offsetInPlace(dx: buttonWidth + buttonSpace, dy: 0)
    }
  }
  
  private func layoutButtonsAlignRight(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    let originX = bounds.maxX - margin - buttonWidth
    var buttonFrame = CGRect(x: originX, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      buttonFrame.offsetInPlace(dx: -(buttonWidth + buttonSpace), dy: 0)
    }
  }
  
}