//
//  DropdownMenuPicker.swift
//  DropdownMenuPicker
//
//  Created by Lasha Efremidze on 9/2/15.
//  Copyright (c) 2015 Lasha Efremidze. All rights reserved.
//

import UIKit
import PinAuto


extension UINavigationController {
  
  struct Associatedkeys{
    static var bx_dropdownMenu = "_bx_dropdownMenu"
  }
  
  public var bx_dropdownMenu: DropdownMenuPicker? {
    get {
      let menu = objc_getAssociatedObject(self, &Associatedkeys.bx_dropdownMenu)
      return menu as? DropdownMenuPicker
    }
    set {
      let oldValue = bx_dropdownMenu
      objc_setAssociatedObject(self, &Associatedkeys.bx_dropdownMenu, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      oldValue?.removeFromSuperview()
      if let newValue = newValue{
        newValue.navigationController = self
        self.view.addSubview(newValue)
      }
    }
  }
  
}

open class MenuItem:UITabBarItem{
  open var icon:UIImage?{
    return image
  }
  open var identifier:String = ""
  
  public init(title :String,icon:UIImage? = nil){
    super.init()
    self.title = title
    self.image = icon
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

open class MenuItemPickerAdapter: NSObject, UITableViewDataSource,UITableViewDelegate{
  open let dropdownMenu:DropdownMenuPicker
  public  init(dropdownMenu:DropdownMenuPicker){
    self.dropdownMenu = dropdownMenu
  }
  
  
  
  
  // MARK: Helper
  func menuAtIndexPath(_ indexPath:IndexPath) -> MenuItem{
    return dropdownMenu.menus[(indexPath as NSIndexPath).row]
  }
  
  
  // MARK: - UITableViewDataSource
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dropdownMenu.menus.count
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: menuItemCellIdentifier, for: indexPath)
    let item = menuAtIndexPath(indexPath)
    cell.textLabel?.text = item.title
    cell.imageView?.image = item.icon
    return cell
  }
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = menuAtIndexPath(indexPath)
    dropdownMenu.didSelectItemAtIndexPath?(item, indexPath)
    dropdownMenu.hideMenu()
  }
}

public let menuItemCellIdentifier = "_bx_menu_item_cell"

open class MenuItemCell:UITableViewCell{
  
  
  open override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    accessoryType = selected ? .checkmark: .none
  }
}

// MARK: - DropdownMenuPicker
open class DropdownMenuPicker: UIView {
  
  open var menus = [MenuItem]()
  
  // handlers
  open var didSelectItemAtIndexPath: ((MenuItem, IndexPath) -> Void)?
  
  // configuration
  open var animationDuration: TimeInterval = 0.3
  open var maskBackgroundColor: UIColor = .black
  open var maskBackgroundOpacity: CGFloat = 0.45
  open var cellBackgroundColor: UIColor = .white
  open var cellSeparatorColor: UIColor = .black
  
  fileprivate weak var navigationController: UINavigationController?
  
  open let backgroundView = UIView()
  open let tableView = UITableView(frame:CGRect.zero,style:.plain)
  open let separatorView = UIView()
  
  fileprivate var tableViewTopConstraint = NSLayoutConstraint()
  fileprivate var tableViewHeight: CGFloat = 44
  
  public init(menus: [MenuItem]) {
    super.init(frame: CGRect.zero)
    self.menus = menus
    adapter = MenuItemPickerAdapter(dropdownMenu: self)
    commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate var adapter: MenuItemPickerAdapter!
  
  var allOutlets:[UIView]{
    return [backgroundView,separatorView,tableView]
  }
  
  override open func willMove(toSuperview newSuperview: UIView?) {
    super.willMove(toSuperview: newSuperview)
    if let navigationController = navigationController {
      var frame = navigationController.view.bounds
      frame.origin.y = navigationController.navigationBar.frame.maxY
      frame.size.height -= frame.origin.y
      self.frame = frame
    }
  }
  
  func commonInit(){
    tableView.register(MenuItemCell.self, forCellReuseIdentifier: menuItemCellIdentifier)
    
    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.clipsToBounds = true
    self.isHidden = true
    
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DropdownMenuPicker.onTabMaskView(_:)))
    backgroundView.addGestureRecognizer(tapGesture)
    
    installConstraints()
    setupAttrs()
  }
  
  
  func installConstraints(){
    backgroundView.pac_edge(0)
    
    separatorView.pac_horizontal(0)
    separatorView.pa_top.eq(0).install()
    separatorView.pa_height.eq(0.5).install()
    
    tableView.pac_horizontal(0)
    tableViewHeight = 44 * CGFloat(menus.count)
    tableView.pa_height.gte(tableViewHeight).install()
    tableViewTopConstraint =  tableView.pa_top.eq(-tableViewHeight).install()
  }
  
  func setupAttrs(){
    // UITableView
    tableView.dataSource = adapter
    tableView.delegate = adapter
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 44
    tableView.tableFooterView = UIView()
    tableView.backgroundColor = .clear
    
  }
  
  @IBAction func onTabMaskView(_ sender:AnyObject){
    hideMenu()
  }
  
  func preshow(){
    backgroundView.backgroundColor = maskBackgroundColor
    tableView.tableHeaderView?.backgroundColor = cellBackgroundColor
    separatorView.backgroundColor = cellSeparatorColor
  }
  
  open func showMenu() {
    preshow()
    
    self.tableView.frame.origin.y = -self.frame.height
    backgroundView.alpha = 0
    self.isHidden = false
    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions(), animations: {
      self.tableViewTopConstraint.constant = 0
      self.backgroundView.alpha = self.maskBackgroundOpacity
      self.setNeedsUpdateConstraints()
      self.layoutIfNeeded()
      }, completion: nil)
  }
  
  open func hideMenu() {
    UIView.animate(withDuration: animationDuration, animations: {
      self.tableViewTopConstraint.constant = -self.tableViewHeight
      self.setNeedsUpdateConstraints()
      self.backgroundView.alpha = 0
      self.layoutIfNeeded()
      }, completion: { _ in
        NSLog("hideMenu Completed")
        self.isHidden = true
    })
  }
  
  open func toggleMenu() {
    if self.isHidden {
      showMenu()
    } else {
      hideMenu()
    }
  }
  
}
