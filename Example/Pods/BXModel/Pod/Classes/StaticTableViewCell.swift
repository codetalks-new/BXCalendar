//
//  StaticTableViewCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/1.
//
//

import UIKit

open class StaticTableViewCell:UITableViewCell {
  open var staticHeight:CGFloat = 44
  open var removeSeparator:Bool = false
  open var removeSeparatorInset:Bool = false
  open var shouldHighlight:Bool = true
  
  
  
  open override var bx_height:CGFloat{ return staticHeight }
  open override var bx_shouldHighlight:Bool{ return shouldHighlight }
}
