//
//  StringExtentions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

public extension String{
  /// Remove leading and trailing whitespace characters
  ///
  /// :return String without leading or trailing whitespace
  public func trimmed() -> String {
    return self.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
  }
}