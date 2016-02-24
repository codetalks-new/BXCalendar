//
//  ConfirmAlertController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/13.
//

import UIKit

public class ConfirmAlertController: UIAlertController {

  public var onConfirmCallback : ( (Bool) -> Void )?
  public var cancelButtonTitle:String = "取消"
  public var okButtonTitle:String = "确定"
  public var shouldShowCancelButton = true
  
  public override func viewDidLoad() {
        super.viewDidLoad()
        if shouldShowCancelButton{
          addAction(UIAlertAction(title: cancelButtonTitle, style: .Cancel){ _ in
                  self.onConfirmCallback?(false)
          })
        }
        addAction(UIAlertAction(title: okButtonTitle, style: .Default){ _ in
                self.onConfirmCallback?(true)
        })
    }

}
