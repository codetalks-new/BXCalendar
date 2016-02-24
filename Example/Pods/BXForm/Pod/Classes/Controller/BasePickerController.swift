//
//  BasePickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation


import UIKit
import PinAutoLayout
import BXiOSUtils

public class BasePickerController: UIViewController {
  
  public let confirmBar = ConfirmButtonBar(frame: CGRectZero)
  
  public var pickerView:UIView{
    fatalError("Should Implements Custom pickerView")
  }
  
  public lazy var dividerView :UIView = {
    let divider = UIView()
    divider.backgroundColor = UIColor(white: 0.912, alpha: 1.0)
    return divider
  }()
  
  private var _confirmBarOnTop = true
  
  public var confirmBarOnTop:Bool{
    get{
      return _confirmBarOnTop
    }set{
      _confirmBarOnTop = newValue
    }
  }
  
  public var confirmBarOnBottom:Bool{
    get{
      return !_confirmBarOnTop
    }set{
      _confirmBarOnTop = !newValue
    }
  }
  
  public convenience init(){
    self.init(nibName: nil, bundle: nil)
  }
  // must needed for iOS 8
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    transitioningDelegate = self
    modalPresentationStyle = .Custom
    modalTransitionStyle = .CoverVertical
    preferredContentSize = CGSize(width: screenWidth, height: 248)
  }
  var allOutlets :[UIView]{
    return [pickerView,confirmBar,dividerView]
  }
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      self.view.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
  }
  
  func installConstaints(){
    confirmBar.setContentCompressionResistancePriority(900, forAxis: .Vertical)
    pickerView.pinHorizontal(0)
    pickerView.clipsToBounds = true
    confirmBar.pinHeight(44)
    confirmBar.pinHorizontal(0)
    
    dividerView.pinHeight(1)
    dividerView.pinHorizontal(0)
    
    if confirmBarOnTop{
      pinTopLayoutGuide(confirmBar)
      pickerView.pinBelowSibling(confirmBar, margin: 0)
      pinBottomLayoutGuide(pickerView)
      dividerView.pinBelowSibling(confirmBar, margin: 0)
    }else{
      pinBottomLayoutGuide(confirmBar)
      pickerView.pinAboveSibling(confirmBar, margin: 0)
      pinTopLayoutGuide(pickerView)
      dividerView.pinAboveSibling(confirmBar, margin: 0)
    }
  }
  
  func setupAttrs(){
  }
  
  override public func loadView(){
    super.loadView()
    self.view.backgroundColor = .whiteColor()
    commonInit()
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    confirmBar.cancelButton.addTarget(self, action: "onCancelButtonPressed:", forControlEvents: .TouchUpInside)
    confirmBar.okButton.addTarget(self, action: "onOkButtonPressed:", forControlEvents: .TouchUpInside)
  }
  
  public var onCancelHandler:( Void -> Void)?
  
  
  @IBAction func onCancelButtonPressed(sender:AnyObject){
    self.dismiss()
    self.onCancelHandler?()
  }
  
  @IBAction func onOkButtonPressed(sender:AnyObject){
    self.dismiss()
    onPickDone()
  }
  
  public func onPickDone(){
    
  }
  
  func dismiss(){
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
}

// MARK: UIViewControllerTransitioningDelegate
extension BasePickerController:UIViewControllerTransitioningDelegate {
  public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
    let presentation = ActionSheetPresentationController(presentedViewController: presented, presentingViewController: presenting)
    return presentation
  }
}