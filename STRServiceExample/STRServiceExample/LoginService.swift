//
//  LoginService.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import ObjectMapper
import STRService

public struct User: Mappable {
    var id: Int?
    var username: String?
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        username    <- map["username"]
        id         <- map["id"]
    }
}

public class LoginService: STRService {
    public typealias ResponseType = User
    
    public var data : RequestData {
        return RequestData(path: "https://jsonplaceholder.typicode.com/users")
    }
    
    public init(){}
}

