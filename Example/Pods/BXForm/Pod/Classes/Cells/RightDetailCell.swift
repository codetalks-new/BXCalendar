//
//  RightDetailCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/24.
//
//

import Foundation
import BXModel

public class RightDetailCell:StaticTableViewCell{
  public convenience init() {
    self.init(style: .Value1, reuseIdentifier: "rightDetailCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
      accessoryType = .DisclosureIndicator
  }
}