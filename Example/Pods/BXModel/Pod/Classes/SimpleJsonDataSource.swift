//
//  SimpleJsonDataSource.swift
//  Pods
//
//  Created by Haizhen Lee on 15/11/8.
//
//

import Foundation
import SwiftyJSON

public class SimpleJsonDataSource<T>:SimpleGenericDataSource<JSON>{
    public init(json:JSON){
        var list = [JSON]()
        for (_,subJson):(String,JSON) in json{
            list.append(subJson)
        }
        super.init(items: list)
    }
}