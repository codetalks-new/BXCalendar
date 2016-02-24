//
//  CheckboxButton.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/9/24.
//

import UIKit

public class CheckboxButton: IconButton {
  public var checkedImage :UIImage?{
    set{
      setImage(newValue, forState: .Selected)
    }get{
      return imageForState(.Selected)
    }
  }
  public var uncheckedImage:UIImage?{
    set{
      setImage(newValue, forState: .Normal)
    }get{
      return imageForState(.Normal)
    }
  }
  
  public override init(frame:CGRect){
    super.init(frame:frame)
    _commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
    _commonInit()
  }
  
  func _commonInit(){
    setTitle(nil, forState: .Normal)
    addTarget(self, action: "_onTap:", forControlEvents: .TouchUpInside)
    selected = false
  }
  
  @IBAction func _onTap(sender:AnyObject){
    selected = !selected
  }
  
  public func toggle(){
    selected = !selected
  }
  
  
}
