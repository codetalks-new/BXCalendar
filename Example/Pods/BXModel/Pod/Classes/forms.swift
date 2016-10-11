//
//  forms.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/30.
//
//

import Foundation

public typealias BXParams = [String:AnyObject]

open class BXField{
  open let name:String
  open let valueType:String
  open var value:AnyObject?
  
  // MARK: Validate
  // Taken from
  open var required:Bool = true
  open var label:String?
  open var label_suffix:String?
  open var help_text:String?
  
  
  
  public init(name:String,valueType:String){
    self.name = name
    self.valueType = valueType
  }
  
  open static func fieldsAsParams(_ fields:[BXField]) -> BXParams{
    var params = BXParams()
    for field in fields{
      if let value = field.value{
        params[field.name] = value
      }
    }
    return params
  }
}

open class BXCharField:BXField{
  open var strip = true
  open var max_length = Int.max
  open var min_length = 0
}

public enum ValidateError:Error{
  case textIsBlank
  case unsupportValueType
  case wrongValueType
  case noValue
}

public struct InvalidFieldError:Error{
  public let field:BXField
  public let error:ValidateError
  public init(field:BXField,error:ValidateError){
    self.field = field
    self.error = error
  }
}

public struct Validators {
  public static  func checkText(_ text:String) throws {
    if text.isEmpty{
      throw ValidateError.textIsBlank
    }
  }
  
  public static func checkField(_ field:BXField) throws {
    do{
      switch field.valueType{
        case "String":
          if let value = field.value as? String{
            try checkText(value)
          }else{
            throw ValidateError.wrongValueType
          }
      default:
        throw ValidateError.unsupportValueType
      }
    }catch let error as ValidateError{
      throw InvalidFieldError(field: field, error: error)
    }
  }
}
