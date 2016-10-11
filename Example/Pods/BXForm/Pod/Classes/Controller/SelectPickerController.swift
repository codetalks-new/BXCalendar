//
//  SingleCompomentPickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit

open class SelectPickerController<T:CustomStringConvertible>:PickerController,UIPickerViewDataSource,UIPickerViewDelegate where T:Equatable{
  fileprivate var options:[T] = []
  open var rowHeight:CGFloat = 36{
    didSet{
      picker.reloadAllComponents()
    }
  }
  open var textColor = UIColor.darkText{
    didSet{
      picker.reloadAllComponents()
    }
  }
  open var font = UIFont.systemFont(ofSize: 14){
    didSet{
      picker.reloadAllComponents()
    }
  }
  
  open var onSelectOption:((T) -> Void)?
  
  public init(options:[T]){
   self.options = options
    super.init(nibName: nil, bundle: nil)
  }
  
  public init(){
    super.init(nibName: nil, bundle: nil)
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
 
  open override func viewDidLoad() {
    super.viewDidLoad()
    picker.delegate = self
    picker.dataSource = self
    picker.showsSelectionIndicator = true
  }
  
  
  open func selectOption(_ option:T){
    let index = options.index { $0 == option }
    if let row = index{
      picker.selectRow(row, inComponent: 0, animated: true)
    }
    
  }
  
  open func updateOptions(_ options:[T]){
    self.options = options
    if isViewLoaded{
      picker.reloadAllComponents()
    }
  }
  
  open func appendOptions(_ options:[T]){
    self.options.append(contentsOf: options)
    picker.reloadAllComponents()
  }
  
  open func appendOption(_ option:T){
    self.options.append(option)
    picker.reloadAllComponents()
  }
  
 
  func optionAtRow(_ row:Int) -> T?{
    if options.count <= row  || row < 0{
      return nil
    }
    return options[row]
  }
  
  // MARK: UIPickerViewDataSource
  open func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return component == 0 ? options.count : 0
  }
  
  
  // MARK: UIPickerViewDelegate
  open func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return rowHeight
  }
  
  open func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    guard let option = optionAtRow(row) else{
      return nil
    }
    let title = option.description
    let attributedText = NSAttributedString(string: title, attributes: [
      NSForegroundColorAttributeName:textColor,
      NSFontAttributeName:font
      ])
    return attributedText
  }

  // MARK: Base Controller
  override open func onPickDone() {
    if options.isEmpty{
      return
    }
    let selectedRow = picker.selectedRow(inComponent: 0)
    if let option = optionAtRow(selectedRow){
      onSelectOption?(option)
    }
  }
  
}
