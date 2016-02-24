//
//  forms.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation

public typealias BXParams = [String:AnyObject]

public class BXField{
  public let name:String
  public let valueType:String
  public var value:AnyObject?
  
  // MARK: Validate
  // Taken from
  public var required:Bool = true
  public var label:String?
  public var label_suffix:String?
  public var help_text:String?
  
  
  
  public init(name:String,valueType:String){
    self.name = name
    self.valueType = valueType
  }
  
  public static func fieldsAsParams(fields:[BXField]) -> BXParams{
    var params = BXParams()
    for field in fields{
      if let value = field.value{
        params[field.name] = value
      }
    }
    return params
  }
}

public class BXCharField:BXField{
  public var strip = true
  public var max_length = Int.max
  public var min_length = 0
}

public enum ValidateError:ErrorType{
  case TextIsBlank
  case UnsupportValueType
  case WrongValueType
  case NoValue
}

public struct InvalidFieldError:ErrorType{
  public let field:BXField
  public let error:ValidateError
  public init(field:BXField,error:ValidateError){
    self.field = field
    self.error = error
  }
}

public struct Validators {
  public static  func checkText(text:String) throws {
    if text.isEmpty{
      throw ValidateError.TextIsBlank
    }
  }
  
  public static func checkField(field:BXField) throws {
    do{
      switch field.valueType{
        case "String":
          if let value = field.value as? String{
            try checkText(value)
          }else{
            throw ValidateError.WrongValueType
          }
      default:
        throw ValidateError.UnsupportValueType
      }
    }catch let error as ValidateError{
      throw InvalidFieldError(field: field, error: error)
    }
  }
}