//
//  SimpleTableViewAdapter.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/11.
//  Copyright © 2015年 xiyili. All rights reserved.
//

import UIKit

open class BXBasicItemTableViewCell:UITableViewCell{
    open class var cellStyle : UITableViewCellStyle{
        return .default
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: type(of: self).cellStyle, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BXBasicItemValue1TableViewCell:BXBasicItemTableViewCell{
    open static override var cellStyle : UITableViewCellStyle{
        return .value1
    }
    
}

open class BXBasicItemValue2TableViewCell:BXBasicItemTableViewCell{
    open static override var cellStyle : UITableViewCellStyle{
        return .value2
    }
}

open class BXBasicItemSubtitleTableViewCell:BXBasicItemTableViewCell{
    open static override var cellStyle : UITableViewCellStyle{
        return .subtitle
    }
}

extension BXBasicItemTableViewCell:BXBindable{
    public func bind(_ item:BXBasicItemAware){
        textLabel?.text = item.bx_text
        detailTextLabel?.text = item.bx_detailText
    }
}

open class SimpleTableViewAdapter<T:BXBasicItemAware>:SimpleGenericTableViewAdapter<T,BXBasicItemTableViewCell>{
    open let cellStyle:UITableViewCellStyle
    open var cellAccessoryType:UITableViewCellAccessoryType = .none
    public init(tableView: UITableView? = nil, items: [T] = [], cellStyle:UITableViewCellStyle = .value2) {
        self.cellStyle = cellStyle
        super.init(tableView: tableView, items: items)
    }
  
    open override func bindTo(_ tableView: UITableView) {
      super.bindTo(tableView)
      tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
    
    var cellClass:BXBasicItemTableViewCell.Type{
        switch cellStyle{
        case .default:return BXBasicItemTableViewCell.self
        case .value1:return BXBasicItemValue1TableViewCell.self
        case .value2:return BXBasicItemValue2TableViewCell.self
        case .subtitle:return BXBasicItemSubtitleTableViewCell.self
        }
    }
    
   
    open override func configureCell(_ cell: BXBasicItemTableViewCell , atIndexPath indexPath: IndexPath) {
       cell.accessoryType = cellAccessoryType
        super.configureCell(cell, atIndexPath: indexPath)
    }
    
}
