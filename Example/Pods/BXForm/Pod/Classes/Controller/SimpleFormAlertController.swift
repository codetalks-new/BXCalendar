//
//  SimpleFormAlertController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/13.
//

import UIKit

open class SimpleFormAlertController: UIAlertController {

    open var cancelButtonTitle:String = "取消"
    open var okButtonTitle:String = "确定"
    open var shouldShowCancelButton = true
    open var onFormSubmitCallback:  (([String:String]) -> Void)?
  
    override open func viewDidLoad() {
        super.viewDidLoad()
        if shouldShowCancelButton{
          addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel,handler:nil))
        }
        addAction(UIAlertAction(title: okButtonTitle, style: .default){ _ in
            var form:[String:String] = [:]
            for (name,field) in self.nameFieldMap{
                form[name] = field.text?.trimmed()
            }
            self.onFormSubmitCallback?(form)
        })
    }
    
    fileprivate var nameFieldMap :[String:UITextField] = [:]
  
    open func setupForm(_ form:[String:String]){
        nameFieldMap.removeAll()
        for (name,label):(String,String) in form{
            addTextField{
                textField in
                textField.placeholder = label
                textField.borderStyle = .none
                self.nameFieldMap[name] = textField
            }
        }
    }

}
