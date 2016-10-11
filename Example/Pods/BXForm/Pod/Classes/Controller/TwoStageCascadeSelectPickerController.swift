//
//  TwoStageCascadeSelectPickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/6/14.
//
//

import UIKit

public protocol ChildPickerItem: CustomStringConvertible,Equatable{
  
}
public protocol ParentPickerItem: CustomStringConvertible,Equatable,Hashable{
}


open class TwoStageCascadeSelectPickerController<T:ParentPickerItem,C:ChildPickerItem>:PickerController,UIPickerViewDataSource,UIPickerViewDelegate{
  public typealias ParentChildDict = Dictionary<T,[C]>
  fileprivate var dict: ParentChildDict = [:]
  fileprivate var parents:[T] = []
  
  open var parentCount:Int{
    return parents.count
  }
  
  open func childCountAtSection(_ section:Int) -> Int{
    return childrenAtSection(section).count
  }
  
  open func childrenAtSection(_ section:Int) -> [C]{
    return dict[parentAtSection(section)]!
  }
  
  open func parentAtSection(_ section:Int) -> T {
    return parents[section]
  }
  
  open func childAtSection(_ section:Int,index:Int) -> C{
    return childrenAtSection(section)[index]
  }
  
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
  
  open var onSelectOption:((T,C) -> Void)?
  
  public init(parents:[T],dict:ParentChildDict){
    super.init(nibName: nil, bundle: nil)
    self.updateOptions(parents,dict:dict)
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
  
  
  open func selectOption(_ option:T,of item:C){
    let index = parents.index { $0 == option }
    if let section = index{
      let rowIndex = childrenAtSection(section).index {$0 == item }
      if let row = rowIndex {
        picker.selectRow(row, inComponent: section, animated: true)
      }
    }
    
  }
  
  open func updateOptions(_ parents:[T],dict:ParentChildDict){
    self.parents = parents
    self.dict = dict
    if isViewLoaded{
      picker.reloadAllComponents()
    }
  }
  

  var selectedSection:Int{
    return picker.selectedRow(inComponent: 0)
  }
  
 
  
  // MARK: UIPickerViewDataSource
  open func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if parents.isEmpty || dict.isEmpty {
      return 0
    }
    switch component{
    case 0: return parents.count
    case 1:
      let parentRow = pickerView.selectedRow(inComponent: 0)
      let count = childCountAtSection(parentRow)
      return count
    default: return 0
    }
  }
  
  
  // MARK: UIPickerViewDelegate
  open func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return rowHeight
  }
  
  open func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let option:CustomStringConvertible
    switch component{
    case 0: option = parentAtSection(row)
    case 1:
      let section = pickerView.selectedRow(inComponent: 0)
      let children = childrenAtSection(section)
      if children.count <= row {
        return nil
      }else{
        option = children[row]
      }
    default:return nil
    }
    let title = option.description
    let attributedText = NSAttributedString(string: title, attributes: [
      NSForegroundColorAttributeName:textColor,
      NSFontAttributeName:font
      ])
    return attributedText
  }
  
  open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0{
      pickerView.reloadComponent(1)
//      if childCountAtSection(1) > 0 {
//        pickerView.selectRow(0, inComponent: 1, animated: true)
//      }
    }
  }
  
  // MARK: Base Controller
  override open func onPickDone() {
    if parents.isEmpty || dict.isEmpty{
      return
    }
    let parentRow = picker.selectedRow(inComponent: 0)
    let childRow = picker.selectedRow(inComponent: 1)
    let parent = parentAtSection(parentRow)
    let children = childrenAtSection(parentRow)
    if children.count <= childRow {
      return
    }
    
    let child = children[childRow]
    onSelectOption?(parent,child)
  }
  
}
