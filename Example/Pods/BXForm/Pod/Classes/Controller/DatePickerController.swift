//
//  DatePickerController.swift
//
//  Created by Haizhen Lee on 15/12/20.
//

import UIKit
import PinAutoLayout
import BXiOSUtils

public class DatePickerController: BasePickerController{
 
  public override var pickerView:UIView {
    return datePicker
  }
  
  public lazy var datePicker:UIDatePicker = {
    let picker = UIDatePicker(frame:CGRectZero)
    let today = NSDate()
    let startDate = NSDate(timeIntervalSinceReferenceDate: 0)
    picker.datePickerMode = .Date
    picker.minimumDate = startDate
    picker.maximumDate = today
    return picker
  }()
  
  public var  pickDoneHandler:(NSDate -> Void)?
  
  override public func onPickDone(){
    self.pickDoneHandler?(date)
  }
  
  public var date:NSDate{
    get{
      return datePicker.date
    }set{
      datePicker.setDate(newValue, animated: true)
    }
  }
  
}

