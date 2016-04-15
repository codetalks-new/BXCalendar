//
//  MultipleSelectViewController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/12.
//


import UIKit
import SwiftyJSON
import BXModel


public class MultipleSelectViewController<T:BXBasicItemAware where T:Hashable>: UITableViewController {
    public private(set) var options:[T] = []
    public let adapter : SimpleTableViewAdapter<T> = SimpleTableViewAdapter<T>(cellStyle:.Default)
    public private(set) var selectedItems :Set<T> = []
    public var completionHandler : ( (Set<T>) -> Void )?
    public var onSelectOption:(T -> Void)?
    public var multiple = true
    public var showSelectToolbar = true
    public var isSelectAll = false
  
   public convenience init(){
    self.init(options:[],style: .Grouped)
  }
  
  public init(options:[T], style:UITableViewStyle = .Plain){
    self.options = options
    adapter.updateItems(options)
    super.init(style: style)
  }
  
  public func updateOptions(options:[T]){
    self.options.removeAll()
    self.options.appendContentsOf(options)
    adapter.updateItems(options)
  }
  
  public func setInitialSelectedItems<S:SequenceType where S.Generator.Element == T>(items:S){
    selectedItems.removeAll()
    selectedItems.unionInPlace(items)
  }
 
  
  public var selectAllButton:UIBarButtonItem?
  private var originalToolbarHidden: Bool?
  public override func loadView() {
    super.loadView()
    originalToolbarHidden = navigationController?.toolbarHidden
    if showSelectToolbar{
      navigationController?.toolbarHidden = false
      navigationController?.toolbar.tintColor = FormColors.primaryColor
      let leftSpaceItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
      let selectAllButton = UIBarButtonItem(title:isSelectAll ? "全不选": "全选", style: .Plain, target: self, action: #selector(MultipleSelectViewController.selectAllButtonPressed(_:)))
      selectAllButton.tintColor = UIColor.blueColor()
      toolbarItems = [leftSpaceItem,selectAllButton]
      self.selectAllButton = selectAllButton
    }
  }
  
  
  func selectAllButtonPressed(sender:AnyObject){
    isSelectAll = !isSelectAll
    selectAllButton?.title = isSelectAll ? "全不选": "全选"
    if isSelectAll{
      selectedItems.unionInPlace(options)
    }else{
      selectedItems.removeAll()
    }
    tableView.reloadData()
  }
  
    public override func viewDidLoad() {
        super.viewDidLoad()
        adapter.updateItems(options)//
        adapter.bindTo(tableView)
      
        adapter.configureCellBlock = { (cell,indexPath) in
                let item = self.adapter.itemAtIndexPath(indexPath)
            cell.accessoryType =  self.selectedItems.contains(item) ? .Checkmark: .None
        }
        tableView.tableFooterView = UIView()
        if multiple{
          let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(MultipleSelectViewController.selectDone(_:)))
          self.navigationItem.rightBarButtonItem = doneButton
        }
      
        adapter.didSelectedItem = { (item,indexPath) in
            self.onSelectItem(item,atIndexPath:indexPath)
        }
    }
    
    func selectDone(sender:AnyObject){
        self.completionHandler?(selectedItems)
        #if DEBUG
        NSLog("selectDone")
        #endif
        let poped = navigationController?.popViewControllerAnimated(true)
      if poped == nil{
          dismissViewControllerAnimated(true, completion: nil)
      }
    }
    
    func onSelectItem(item:T,atIndexPath indexPath:NSIndexPath){
        guard let  cell = tableView.cellForRowAtIndexPath(indexPath) else{
            return
        }
      
      
        if selectedItems.contains(item){
            selectedItems.remove(item)
        }else{
            selectedItems.insert(item)
        }
       
        let isChecked = selectedItems.contains(item)
        cell.accessoryType = isChecked ? .Checkmark : .None
      
        if !multiple{
          self.onSelectOption?(item)
          selectDone(cell)
        }
    }
  
  public override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    if let state = originalToolbarHidden{
      navigationController?.setToolbarHidden(state, animated: true)
    }
  }

  public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.min
  }

}
