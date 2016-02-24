//
//  PickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

public class PickerController:BasePickerController{
  
  public override var pickerView:UIView{
    return self.picker
  }
  
  public lazy var picker:UIPickerView = {
    let picker = UIPickerView(frame: CGRectZero)
    return picker
  }()
}
