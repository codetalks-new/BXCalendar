//
//  BasePickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation


import UIKit
import PinAuto
import BXiOSUtils

open class BasePickerController: UIViewController {
  
  open let confirmBar = ConfirmButtonBar(frame: CGRect.zero)
  
  open var pickerView:UIView{
    fatalError("Should Implements Custom pickerView")
  }
  
  open lazy var dividerView :UIView = {
    let divider = UIView()
    divider.backgroundColor = UIColor(white: 0.912, alpha: 1.0)
    return divider
  }()
  
  fileprivate var _confirmBarOnTop = true
  
  open var confirmBarOnTop:Bool{
    get{
      return _confirmBarOnTop
    }set{
      _confirmBarOnTop = newValue
    }
  }
  
  open var confirmBarOnBottom:Bool{
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
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    transitioningDelegate = self
    modalPresentationStyle = .custom
    modalTransitionStyle = .coverVertical
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
    confirmBar.setContentCompressionResistancePriority(900, for: .vertical)
    pickerView.pac_horizontal(0) //pinHorizontal(0)
    pickerView.clipsToBounds = true
    confirmBar.pa_height.eq(44).install() // pa_height.eq(44)
    confirmBar.pac_horizontal(0)
    
    dividerView.pa_height.eq(1).install()
    dividerView.pac_horizontal(0)
    
    if confirmBarOnTop{
      confirmBar.pa_below(topLayoutGuide).install()
      pickerView.pa_below(confirmBar, offset: 0).install()
      pickerView.pa_above(bottomLayoutGuide).install()
      dividerView.pa_below(confirmBar, offset: 0).install()
    }else{
      confirmBar.pa_above(bottomLayoutGuide).install()
      pickerView.pa_above(confirmBar, offset: 0).install()
      pickerView.pa_below(topLayoutGuide).install()
      dividerView.pa_above(confirmBar, offset: 0).install()
    }
  }
  
  func setupAttrs(){
  }
  
  override open func loadView(){
    super.loadView()
    self.view.backgroundColor = .white
    commonInit()
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    confirmBar.cancelButton.addTarget(self, action: #selector(BasePickerController.onCancelButtonPressed(_:)), for: .touchUpInside)
    confirmBar.okButton.addTarget(self, action: #selector(BasePickerController.onOkButtonPressed(_:)), for: .touchUpInside)
  }
  
  open var onCancelHandler:( (Void) -> Void)?
  
  
  @IBAction func onCancelButtonPressed(_ sender:AnyObject){
    self.dismiss()
    self.onCancelHandler?()
  }
  
  @IBAction func onOkButtonPressed(_ sender:AnyObject){
    self.dismiss()
    onPickDone()
  }
  
  open func onPickDone(){
    
  }
  
  func dismiss(){
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  
}

// MARK: UIViewControllerTransitioningDelegate
extension BasePickerController:UIViewControllerTransitioningDelegate {
  public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let presentation = ActionSheetPresentationController(presentedViewController: presented, presenting: presenting!)
    return presentation
  }
}
