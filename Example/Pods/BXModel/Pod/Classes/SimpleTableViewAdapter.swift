//
//  SimpleTableViewAdapter.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/11.
//  Copyright © 2015年 xiyili. All rights reserved.
//

import UIKit

public class BXBasicItemTableViewCell:UITableViewCell{
    public class var cellStyle : UITableViewCellStyle{
        return .Default
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: self.dynamicType.cellStyle, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class BXBasicItemValue1TableViewCell:BXBasicItemTableViewCell{
    public static override var cellStyle : UITableViewCellStyle{
        return .Value1
    }
    
}

public class BXBasicItemValue2TableViewCell:BXBasicItemTableViewCell{
    public static override var cellStyle : UITableViewCellStyle{
        return .Value2
    }
}

public class BXBasicItemSubtitleTableViewCell:BXBasicItemTableViewCell{
    public static override var cellStyle : UITableViewCellStyle{
        return .Subtitle
    }
}

extension BXBasicItemTableViewCell:BXBindable{
    public func bind(item:BXBasicItemAware){
        textLabel?.text = item.bx_text
        detailTextLabel?.text = item.bx_detailText
    }
}

public class SimpleTableViewAdapter<T:BXBasicItemAware>:SimpleGenericTableViewAdapter<T,BXBasicItemTableViewCell>{
    public let cellStyle:UITableViewCellStyle
    public var cellAccessoryType:UITableViewCellAccessoryType = .None
    public init(tableView: UITableView? = nil, items: [T] = [], cellStyle:UITableViewCellStyle = .Value2) {
        self.cellStyle = cellStyle
        super.init(tableView: tableView, items: items)
    }
  
    public override func bindTo(tableView: UITableView) {
      super.bindTo(tableView)
      tableView.registerClass(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
    
    var cellClass:BXBasicItemTableViewCell.Type{
        switch cellStyle{
        case .Default:return BXBasicItemTableViewCell.self
        case .Value1:return BXBasicItemValue1TableViewCell.self
        case .Value2:return BXBasicItemValue2TableViewCell.self
        case .Subtitle:return BXBasicItemSubtitleTableViewCell.self
        }
    }
    
   
    public override func configureCell(cell: BXBasicItemTableViewCell , atIndexPath indexPath: NSIndexPath) {
       cell.accessoryType = cellAccessoryType
        super.configureCell(cell, atIndexPath: indexPath)
    }
    
}