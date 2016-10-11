//
//  RadioItem.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation
import BXModel

public protocol BXRadioItemAware:BXModelAware{
  var bx_title:String{ get }
}

open class BXRadioItem:BXModelAware{
  let title:String
  
  init(title:String){
    self.title = title
  }
}

extension BXRadioItem:Equatable{
  
}

public func ==(lhs:BXRadioItem,rhs:BXRadioItem) -> Bool{
  return lhs.title == rhs.title
}
