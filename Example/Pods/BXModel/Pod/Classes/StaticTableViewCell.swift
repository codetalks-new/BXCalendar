//
//  StaticTableViewCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/1.
//
//

import UIKit

public class StaticTableViewCell:UITableViewCell {
  public var staticHeight:CGFloat = 44
  public var removeSeparator:Bool = false
  public var removeSeparatorInset:Bool = false
  public var shouldHighlight:Bool = true
  
  public override var bx_height:CGFloat{ return staticHeight }
  public override var bx_shouldHighlight:Bool{ return shouldHighlight }
}
