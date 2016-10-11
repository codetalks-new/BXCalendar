//
//  BXCalendarViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import UIKit
import BXForm

open class BXCalendarViewController:UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate{
  open var firstMonthDate:Foundation.Date!
  
  public init(){
   super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }
  
  public required init?(coder: NSCoder) {
   super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
  }
  
  open var readonly = false
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    if firstMonthDate == nil{
      firstMonthDate = Foundation.Date()
    }
    dataSource = self
    delegate = self
    
    view.layer.cornerRadius = FormMetrics.cornerRadius
    
    let initialVC = pageViewControllerOf(monthDate:firstMonthDate)
    setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
  }
  
  // MARK: UIPageViewControllerDataSource
  open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
    guard let mvc = viewController as? BXCalendarMonthViewController else{
      return nil
    }
    let prevMonthDate = mvc.monthDate.prevMonthDate
    return pageViewControllerOf(monthDate:prevMonthDate)
  }
  
  open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
    guard let mvc = viewController as? BXCalendarMonthViewController else{
      return nil
    }
    let nextMonthDate = mvc.monthDate.nextMonthDate
    return pageViewControllerOf(monthDate:nextMonthDate)
  }
  
  // MARK: Helper
  func pageViewControllerOf(monthDate date:Foundation.Date) -> BXCalendarMonthViewController{
    let vc = BXCalendarMonthViewController()
    vc.monthDate = date
    vc.readonly = readonly
    vc.monthHeaderView.okButton.addTarget(self, action: #selector(onOkButtonPressed(_:)), for: .touchUpInside)
    vc.monthHeaderView.cancelButton.addTarget(self, action: #selector(onCancelButtonPressed(_:)), for: .touchUpInside)
    return vc
  }
  
  func onOkButtonPressed(_ sender:AnyObject){
    didSelectedDates?(DateManager.sharedManager.dateSet)
    dismiss()
  }
  
  func onCancelButtonPressed(_ sender:AnyObject){
    onCancelBlock?()
    dismiss()
  }
  
  open func updateSelectedDates(_ dates:[Foundation.Date]){
    DateManager.sharedManager.removeAll()
    for d in dates{
      DateManager.sharedManager.add(d)
    }
    if let date = dates.first{
      firstMonthDate = date
    }
  }
  
  open func dismiss(){
    bx_closeSelf()
  }
  
  open var didSelectedDates: ((Set<YMDDate>) -> Void)?
  open var onCancelBlock: ((Void) -> Void)?
}
