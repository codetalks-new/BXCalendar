//
//  UIDeviceExtenstions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/18.
//
//

import UIKit

public extension UIDevice{
  public func bx_isSimulator() -> Bool{
    return self.model.containsString("Simulator")
  }
}
