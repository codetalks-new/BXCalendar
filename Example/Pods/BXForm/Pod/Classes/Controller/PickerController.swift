//
//  PickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

open class PickerController:BasePickerController{
  
  open override var pickerView:UIView{
    return self.picker
  }
  
  open lazy var picker:UIPickerView = {
    let picker = UIPickerView(frame: CGRect.zero)
    return picker
  }()
}
