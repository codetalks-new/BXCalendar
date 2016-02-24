//
//  SimpleFormAlertController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/13.
//

import UIKit

public class SimpleFormAlertController: UIAlertController {

    public var cancelButtonTitle:String = "取消"
    public var okButtonTitle:String = "确定"
    public var shouldShowCancelButton = true
    public var onFormSubmitCallback:  ([String:String] -> Void)?
  
    override public func viewDidLoad() {
        super.viewDidLoad()
        if shouldShowCancelButton{
          addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel,handler:nil))
        }
        addAction(UIAlertAction(title: okButtonTitle, style: .Default){ _ in
            var form:[String:String] = [:]
            for (name,field) in self.nameFieldMap{
                form[name] = field.text?.trimmed()
            }
            self.onFormSubmitCallback?(form)
        })
    }
    
    private var nameFieldMap :[String:UITextField] = [:]
  
    public func setupForm(form:[String:String]){
        nameFieldMap.removeAll()
        for (name,label):(String,String) in form{
            addTextFieldWithConfigurationHandler{
                textField in
                textField.placeholder = label
                textField.borderStyle = .None
                self.nameFieldMap[name] = textField
            }
        }
    }

}
