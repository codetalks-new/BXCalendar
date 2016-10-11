//
//  UITableViewCell+Helper.swift
//  Pods
//
//  Created by Haizhen Lee on 16/7/4.
//
//

import UIKit


extension UITableViewCell{
  
  public var title:String?{
    set{
      textLabel?.text = newValue
    }get{
      return textLabel?.text
    }
  }
  
  public var detail:String?{
    set{
      detailTextLabel?.text = newValue
    }get{
      return detailTextLabel?.text
    }
  }
}