//
//  MultipleSelectViewController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/12.
//


import UIKit
import SwiftyJSON
import BXModel


open class MultipleSelectViewController<T:BXBasicItemAware>: UITableViewController where T:Hashable {
    open fileprivate(set) var options:[T] = []
    open let adapter : SimpleTableViewAdapter<T> = SimpleTableViewAdapter<T>(cellStyle:.default)
    open fileprivate(set) var selectedItems :Set<T> = []
    open var completionHandler : ( (Set<T>) -> Void )?
    open var onSelectOption:((T) -> Void)?
    open var multiple = true
    open var showSelectToolbar = true
    open var isSelectAll = false
  
   public convenience init(){
    self.init(options:[],style: .grouped)
  }
  
  public init(options:[T], style:UITableViewStyle = .plain){
    self.options = options
    adapter.updateItems(options)
    super.init(style: style)
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  open func updateOptions(_ options:[T]){
    self.options.removeAll()
    self.options.append(contentsOf: options)
    adapter.updateItems(options)
  }
  
  open func setInitialSelectedItems<S:Sequence>(_ items:S) where S.Iterator.Element == T{
    selectedItems.removeAll()
    selectedItems.formUnion(items)
  }
 
  
  open var selectAllButton:UIBarButtonItem?
  fileprivate var originalToolbarHidden: Bool?
  open override func loadView() {
    super.loadView()
    originalToolbarHidden = navigationController?.isToolbarHidden
    if showSelectToolbar{
      navigationController?.isToolbarHidden = false
      navigationController?.toolbar.tintColor = FormColors.primaryColor
      let leftSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let selectAllButton = UIBarButtonItem(title:isSelectAll ? "全不选": "全选", style: .plain, target: self, action: #selector(MultipleSelectViewController.selectAllButtonPressed(_:)))
      selectAllButton.tintColor = UIColor.blue
      toolbarItems = [leftSpaceItem,selectAllButton]
      self.selectAllButton = selectAllButton
    }
  }
  
  
  func selectAllButtonPressed(_ sender:AnyObject){
    isSelectAll = !isSelectAll
    selectAllButton?.title = isSelectAll ? "全不选": "全选"
    if isSelectAll{
      selectedItems.formUnion(options)
    }else{
      selectedItems.removeAll()
    }
    tableView.reloadData()
  }
  
    open override func viewDidLoad() {
        super.viewDidLoad()
        adapter.updateItems(options)//
        adapter.bindTo(tableView)
      
        adapter.configureCellBlock = { (cell,indexPath) in
                let item = self.adapter.itemAtIndexPath(indexPath)
            cell.accessoryType =  self.selectedItems.contains(item) ? .checkmark: .none
        }
        tableView.tableFooterView = UIView()
        if multiple{
          let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MultipleSelectViewController.selectDone(_:)))
          self.navigationItem.rightBarButtonItem = doneButton
        }
      
        adapter.didSelectedItem = { (item,indexPath) in
            self.onSelectItem(item,atIndexPath:indexPath)
        }
    }
    
    func selectDone(_ sender:AnyObject){
        self.completionHandler?(selectedItems)
        #if DEBUG
        NSLog("selectDone")
        #endif
        let poped = navigationController?.popViewController(animated: true)
      if poped == nil{
          dismiss(animated: true, completion: nil)
      }
    }
    
    func onSelectItem(_ item:T,atIndexPath indexPath:IndexPath){
        guard let  cell = tableView.cellForRow(at: indexPath) else{
            return
        }
      
      
        if selectedItems.contains(item){
            selectedItems.remove(item)
        }else{
            selectedItems.insert(item)
        }
       
        let isChecked = selectedItems.contains(item)
        cell.accessoryType = isChecked ? .checkmark : .none
      
        if !multiple{
          self.onSelectOption?(item)
          selectDone(cell)
        }
    }
  
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if let state = originalToolbarHidden{
      navigationController?.setToolbarHidden(state, animated: true)
    }
  }

  open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }

}
