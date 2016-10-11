//
//  DatePickerController.swift
//
//  Created by Haizhen Lee on 15/12/20.
//

import UIKit
import PinAuto
import BXiOSUtils

open class DatePickerController: BasePickerController{
 
  open override var pickerView:UIView {
    return datePicker
  }
  
  open lazy var datePicker:UIDatePicker = {
    let picker = UIDatePicker(frame:CGRect.zero)
    let today = Date()
    let startDate = Date(timeIntervalSinceReferenceDate: 0)
    picker.datePickerMode = .date
    picker.minimumDate = startDate
    picker.maximumDate = today
    return picker
  }()
  
  open var  pickDoneHandler:((Date) -> Void)?
  
  override open func onPickDone(){
    self.pickDoneHandler?(date)
  }
  
  open var date:Date{
    get{
      return datePicker.date
    }set{
      datePicker.setDate(newValue, animated: true)
    }
  }
  
}

