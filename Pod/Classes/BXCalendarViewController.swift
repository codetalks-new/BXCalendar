//
//  BXCalendarViewController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/2/24.
//
//

import UIKit
import BXForm

public class BXCalendarViewController:UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate{
  public var firstMonthDate:NSDate!
  
  public init(){
   super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
  }
  
  public required init?(coder: NSCoder) {
   super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
  }
  
  public var readonly = false
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    if firstMonthDate == nil{
      firstMonthDate = NSDate()
    }
    dataSource = self
    delegate = self
    
    view.layer.cornerRadius = FormMetrics.cornerRadius
    
    let initialVC = pageViewControllerOfMonthDate(firstMonthDate)
    setViewControllers([initialVC], direction: .Forward, animated: false, completion: nil)
  }
  
  // MARK: UIPageViewControllerDataSource
  public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
    guard let mvc = viewController as? BXCalendarMonthViewController else{
      return nil
    }
    let prevMonthDate = mvc.monthDate.prevMonthDate
    return pageViewControllerOfMonthDate(prevMonthDate)
  }
  
  public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
    guard let mvc = viewController as? BXCalendarMonthViewController else{
      return nil
    }
    let nextMonthDate = mvc.monthDate.nextMonthDate
    return pageViewControllerOfMonthDate(nextMonthDate)
  }
  
  // MARK: Helper
  func pageViewControllerOfMonthDate(date:NSDate) -> BXCalendarMonthViewController{
    let vc = BXCalendarMonthViewController()
    vc.monthDate = date
    vc.readonly = readonly
    vc.monthHeaderView.okButton.addTarget(self, action: #selector(onOkButtonPressed(_:)), forControlEvents: .TouchUpInside)
    vc.monthHeaderView.cancelButton.addTarget(self, action: #selector(onCancelButtonPressed(_:)), forControlEvents: .TouchUpInside)
    return vc
  }
  
  func onOkButtonPressed(sender:AnyObject){
    didSelectedDates?(DateManager.sharedManager.dateSet)
    dismiss()
  }
  
  func onCancelButtonPressed(sender:AnyObject){
    onCancelBlock?()
    dismiss()
  }
  
  public func updateSelectedDates(dates:[NSDate]){
    DateManager.sharedManager.removeAll()
    for d in dates{
      DateManager.sharedManager.add(d)
    }
    if let date = dates.first{
      firstMonthDate = date
    }
  }
  
  public func dismiss(){
    bx_closeSelf()
  }
  
  public var didSelectedDates: (Set<Date> -> Void)?
  public var onCancelBlock: (Void -> Void)?
}
