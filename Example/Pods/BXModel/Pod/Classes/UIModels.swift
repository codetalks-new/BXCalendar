//
//  UIModels.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/10.
//
//

import Foundation

public protocol BXBindable{
    associatedtype ModelType
    func bind(item:ModelType)
}

public protocol BXNibable{
    associatedtype CustomViewClass
    static var hasNib:Bool{ get }
    static func nib() -> UINib
    static func instantiate() -> CustomViewClass
}


extension UIView:BXNibable{
  public typealias CustomViewClass = UIView
    public static var hasNib:Bool{
        let name = simpleClassName(self)
        let bundle = NSBundle(forClass: self)
        let path = bundle.pathForResource(name, ofType: "nib")
        return path != nil
    }
    
    public static func nib() -> UINib{
        let name = simpleClassName(self)
        return UINib(nibName: name, bundle: NSBundle(forClass: self))
    }
  
  
    public static func instantiate() -> CustomViewClass{
        return nib().instantiateWithOwner(self, options: nil).first as! CustomViewClass
    }
}

class MyCustomButton:UIButton{
 internal typealias CustomViewClass = MyCustomButton
  

}

let button = MyCustomButton.instantiate()


