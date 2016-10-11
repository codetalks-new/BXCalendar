//
//  RightDetailCell.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/24.
//
//

import Foundation
import BXModel

open class RightDetailCell:StaticTableViewCell{
  public convenience init() {
    self.init(style: .value1, reuseIdentifier: "rightDetailCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open func commonInit(){
      accessoryType = .disclosureIndicator
      textLabel?.textColor = FormColors.primaryTextColor
  }
}
