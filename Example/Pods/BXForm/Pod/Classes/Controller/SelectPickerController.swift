//
//  SingleCompomentPickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

public class SelectPickerController<T:CustomStringConvertible where T:Equatable>:PickerController,UIPickerViewDataSource,UIPickerViewDelegate{
  private var options:[T] = []
  public var rowHeight:CGFloat = 36{
    didSet{
      picker.reloadAllComponents()
    }
  }
  public var textColor = UIColor.darkTextColor(){
    didSet{
      picker.reloadAllComponents()
    }
  }
  public var font = UIFont.systemFontOfSize(14){
    didSet{
      picker.reloadAllComponents()
    }
  }
  
  public var onSelectOption:(T -> Void)?
  
  public init(options:[T]){
   self.options = options
    super.init(nibName: nil, bundle: nil)
  }
  
  public init(){
    super.init(nibName: nil, bundle: nil)
  }
 
  public override func viewDidLoad() {
    super.viewDidLoad()
    picker.delegate = self
    picker.dataSource = self
    picker.showsSelectionIndicator = true
  }
  
  
  public func selectOption(option:T){
    let index = options.indexOf { $0 == option }
    if let row = index{
      picker.selectRow(row, inComponent: 0, animated: true)
    }
    
  }
  
  public func updateOptions(options:[T]){
    self.options = options
    if isViewLoaded(){
      picker.reloadAllComponents()
    }
  }
  
  public func appendOptions(options:[T]){
    self.options.appendContentsOf(options)
    picker.reloadAllComponents()
  }
  
  public func appendOption(option:T){
    self.options.append(option)
    picker.reloadAllComponents()
  }
  
 
  func optionAtRow(row:Int) -> T{
    return options[row]
  }
  
  // MARK: UIPickerViewDataSource
  public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return component == 0 ? options.count : 0
  }
  
  
  // MARK: UIPickerViewDelegate
  public func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return rowHeight
  }
  
  public func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let title = optionAtRow(row).description
    let attributedText = NSAttributedString(string: title, attributes: [
      NSForegroundColorAttributeName:textColor,
      NSFontAttributeName:font
      ])
    return attributedText
  }

  // MARK: Base Controller
  override public func onPickDone() {
    let selectedRow = picker.selectedRowInComponent(0)
    let option = optionAtRow(selectedRow)
    onSelectOption?(option)
  }
  
}
