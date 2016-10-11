//
//  CheckboxButton.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/9/24.
//

import UIKit

open class CheckboxButton: IconButton {
  open var checkedImage :UIImage?{
    set{
      setImage(newValue, for: .selected)
    }get{
      return image(for: .selected)
    }
  }
  open var uncheckedImage:UIImage?{
    set{
      setImage(newValue, for: UIControlState())
    }get{
      return image(for: UIControlState())
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
    setTitle(nil, for: UIControlState())
    addTarget(self, action: #selector(CheckboxButton._onTap(_:)), for: .touchUpInside)
    isSelected = false
  }
  
  @IBAction func _onTap(_ sender:AnyObject){
    isSelected = !isSelected
    checkedStateChangedCallback?(isSelected)
  }
  
  open func toggle(){
    isSelected = !isSelected
  }
  
  open var checkedStateChangedCallback: ( (Bool) -> Void )?
  
  
}
