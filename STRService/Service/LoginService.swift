//
//  LoginService.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
import ObjectMapper
public struct User: Mappable {
    public init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        
    }
    
    let id: Int
    let username: String
}

public class LoginService: STRService {
    typealias ResponseType = [User]
    
    public var data : RequestData {
        return RequestData(path: "https://jsonplaceholder.typicode.com/users")
    }
    
    public init(){}
}

