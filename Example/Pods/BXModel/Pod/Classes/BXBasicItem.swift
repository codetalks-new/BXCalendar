//
//  base_protocol.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/9.
//  Copyright © 2015年 xiyili. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol BXTextItemAware{
    var bx_text:String { get }
}

public protocol BXDetailTextItemAware{
    var bx_detailText:String{ get }
}

public protocol BXBasicItemAware:BXTextItemAware,BXDetailTextItemAware{
    
}

extension String:BXBasicItemAware{
  public var bx_text:String{return self}
  public var bx_detailText:String{ return ""}
}

open class BXBasicItem: BXBasicItemAware{
    open let text:String
    open let detailText:String
    
    open var bx_text:String { return text }
    open var bx_detailText:String { return detailText }
    
    public init(text:String,detailText:String){
        self.text = text
        self.detailText = detailText
    }
    
    public required init(json: JSON) {
       self.text = json["text"].stringValue
        self.detailText = json["detailText"].stringValue
    }
}
