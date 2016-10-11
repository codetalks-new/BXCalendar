//
//  SelectAlertController.swift
//
//  Created by Haizhen Lee on 15/11/12.
//

import UIKit

open class SelectAlertController<T:CustomStringConvertible>: UIAlertController {
    let options:[T]
    open var onSelectCallback : ( (T) -> Void )?
    
    public init(options:[T]){
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.options = []
        super.init(coder: aDecoder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        for option in options {
            let action = UIAlertAction(title: option.description, style: .default) { [weak self] _ in
                self?.onSelectCallback?(option)
            }
            addAction(action)
        }
    }
    
}
