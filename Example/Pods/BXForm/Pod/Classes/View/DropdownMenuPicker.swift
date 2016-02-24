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

public class MenuItem:UITabBarItem{
  public var icon:UIImage?{
    return image
  }
  public var identifier:String = ""
  
  public init(title :String,icon:UIImage? = nil){
    super.init()
    self.title = title
    self.image = icon
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

public class MenuItemPickerAdapter: NSObject, UITableViewDataSource,UITableViewDelegate{
  public let dropdownMenu:DropdownMenuPicker
  public  init(dropdownMenu:DropdownMenuPicker){
    self.dropdownMenu = dropdownMenu
  }
  
  
  
  
  // MARK: Helper
  func menuAtIndexPath(indexPath:NSIndexPath) -> MenuItem{
    return dropdownMenu.menus[indexPath.row]
  }
  
  
  // MARK: - UITableViewDataSource
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dropdownMenu.menus.count
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(menuItemCellIdentifier, forIndexPath: indexPath)
    let item = menuAtIndexPath(indexPath)
    cell.textLabel?.text = item.title
    cell.imageView?.image = item.icon
    return cell
  }
  
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item = menuAtIndexPath(indexPath)
    dropdownMenu.didSelectItemAtIndexPath?(item, indexPath)
    dropdownMenu.hideMenu()
  }
}

public let menuItemCellIdentifier = "_bx_menu_item_cell"

public class MenuItemCell:UITableViewCell{
  
  
  public override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    accessoryType = selected ? .Checkmark: .None
  }
}

// MARK: - DropdownMenuPicker
public class DropdownMenuPicker: UIView {
  
  public var menus = [MenuItem]()
  
  // handlers
  public var didSelectItemAtIndexPath: ((MenuItem, NSIndexPath) -> Void)?
  
  // configuration
  public var animationDuration: NSTimeInterval = 0.3
  public var maskBackgroundColor: UIColor = .blackColor()
  public var maskBackgroundOpacity: CGFloat = 0.45
  public var cellBackgroundColor: UIColor = .whiteColor()
  public var cellSeparatorColor: UIColor = .blackColor()
  
  private weak var navigationController: UINavigationController?
  
  public let backgroundView = UIView()
  public let tableView = UITableView(frame:CGRectZero,style:.Plain)
  public let separatorView = UIView()
  
  private var tableViewTopConstraint = NSLayoutConstraint()
  private var tableViewHeight: CGFloat = 44
  
  public init(menus: [MenuItem]) {
    super.init(frame: CGRectZero)
    self.menus = menus
    adapter = MenuItemPickerAdapter(dropdownMenu: self)
    commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  private var adapter: MenuItemPickerAdapter!
  
  var allOutlets:[UIView]{
    return [backgroundView,separatorView,tableView]
  }
  
  override public func willMoveToSuperview(newSuperview: UIView?) {
    super.willMoveToSuperview(newSuperview)
    if let navigationController = navigationController {
      var frame = navigationController.view.bounds
      frame.origin.y = navigationController.navigationBar.frame.maxY
      frame.size.height -= frame.origin.y
      self.frame = frame
    }
  }
  
  func commonInit(){
    tableView.registerClass(MenuItemCell.self, forCellReuseIdentifier: menuItemCellIdentifier)
    
    self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.clipsToBounds = true
    self.hidden = true
    
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let tapGesture = UITapGestureRecognizer(target: self, action: "onTabMaskView:")
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
    tableView.backgroundColor = .clearColor()
    
  }
  
  @IBAction func onTabMaskView(sender:AnyObject){
    hideMenu()
  }
  
  func preshow(){
    backgroundView.backgroundColor = maskBackgroundColor
    tableView.tableHeaderView?.backgroundColor = cellBackgroundColor
    separatorView.backgroundColor = cellSeparatorColor
  }
  
  public func showMenu() {
    preshow()
    
    self.tableView.frame.origin.y = -self.frame.height
    backgroundView.alpha = 0
    self.hidden = false
    UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
      self.tableViewTopConstraint.constant = 0
      self.backgroundView.alpha = self.maskBackgroundOpacity
      self.setNeedsUpdateConstraints()
      self.layoutIfNeeded()
      }, completion: nil)
  }
  
  public func hideMenu() {
    UIView.animateWithDuration(animationDuration, animations: {
      self.tableViewTopConstraint.constant = -self.tableViewHeight
      self.setNeedsUpdateConstraints()
      self.backgroundView.alpha = 0
      self.layoutIfNeeded()
      }, completion: { _ in
        NSLog("hideMenu Completed")
        self.hidden = true
    })
  }
  
  public func toggleMenu() {
    if self.hidden {
      showMenu()
    } else {
      hideMenu()
    }
  }
  
}
