//
//  LoginService.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
public struct User: Codable {
    let id: Int
    let username: String
}

public class LoginService: STRService {
    public var data : RequestData {
        return RequestData(path: "https://jsonplaceholder.typicode.com/users")
    }
    
    public init(){}
}

