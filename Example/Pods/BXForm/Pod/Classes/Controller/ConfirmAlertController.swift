//
//  ConfirmAlertController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/13.
//

import UIKit

open class ConfirmAlertController: UIAlertController {

  open var onConfirmCallback : ( (Bool) -> Void )?
  open var cancelButtonTitle:String = "取消"
  open var okButtonTitle:String = "确定"
  open var shouldShowCancelButton = true
  
  open override func viewDidLoad() {
        super.viewDidLoad()
        if shouldShowCancelButton{
          addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel){ _ in
                  self.onConfirmCallback?(false)
          })
        }
        addAction(UIAlertAction(title: okButtonTitle, style: .default){ _ in
                self.onConfirmCallback?(true)
        })
    }

}
