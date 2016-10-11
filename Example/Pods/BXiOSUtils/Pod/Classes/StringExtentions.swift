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
    return self.trimmingCharacters(in: .whitespaces)
  }
}

public extension String{
  public var quietUrl:URL{
    if let url = URL(string: self) {
      return url
    }
    if let escapedString = self.addingPercentEscapes(using: String.Encoding.utf8){
      if let url = URL(string: escapedString) {
        return url
      }
    }
    return URL(string: "")!
  }
}
