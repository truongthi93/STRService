//
//  STRAPI.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation
import Alamofire

public enum ConnError: Swift.Error {
    case invalidURL
    case noData
    case dataError
}

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String:Any?]?
    public let headers: [String: String]?
    
    init(path: String,
         method: HTTPMethod = .get,
         params: [String: Any?]? = nil,
         headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}

public protocol STRService {
    var data: RequestData { get }
    
    var config : STRConfig? {get set}
}

public struct URLSessionNetworkDispatcher {
    
    public static let instance = URLSessionNetworkDispatcher()
    
    private init() {}
    
    public func dispatch(requestData: RequestData, onSuccess: @escaping (NSDictionary) -> Void, onError: @escaping (Error) -> Void) {
        guard let parameters = requestData.params else {
            onError(ConnError.dataError)
            return
        }
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseJSON {
            response in
            
            
            if let error = response.error {
                onError(error)
                return
            }
            
            guard let data = response.result.value else {
                onError(ConnError.noData)
                return
            }
            guard let dic = data as? NSDictionary else {return}
            
            onSuccess(dic)
        }
    }
    
    
    func responseHandler() {
        
    }
}

public extension STRService {
    
    public func execute(dispatcher: URLSessionNetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping (NSDictionary) -> Void,
                        onError: @escaping (Error) -> Void) {
    
        
        dispatcher.dispatch(requestData: self.data, onSuccess: { (data) in
            
            onSuccess(data)
            
        }) { (error) in
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}
