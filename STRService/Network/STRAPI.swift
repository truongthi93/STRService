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
    case noResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case requestTimeout
    case gatewayTimeout
    case badGateway
    case internalServerError
}

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public var params: [String:Any?]?
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
}

public struct URLSessionNetworkDispatcher {
    
    public static let instance = URLSessionNetworkDispatcher()
    
    private init() {}
    
    public func dispatch(requestData: RequestData, onSuccess: @escaping (Any) -> Void, onError: @escaping (Error) -> Void) {
//        guard let parameters = requestData.params else {
//            onError(ConnError.dataError)
//            return
//        }
        let parameters = ["d":"d"]
        
        STRNetworkManager.shared.networkManager?.request(requestData.path, method: requestData.method, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: requestData.headers).responseJSON {
            response in

            self.responseHandler(response: response, onSuccess: { (dic) in
                onSuccess(dic)
            }, onError: { (error) in
                onError(error)
            })
            
        }
    }
    
    
    func responseHandler(response:DataResponse<Any>, onSuccess: @escaping(Any) -> Void, onError:@escaping(Error) -> Void) {
        guard let statusCode = response.response?.statusCode else {
            onError(ConnError.noResponse)
            return
        }
        
        switch statusCode {
        case 200:
            guard let data = response.result.value else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(data)
            
        // Bad Request
        case 400:
            STRConfig.shared.delegate?.showError(error: ConnError.badRequest)
        //Unauthorized
        case 401:
            STRConfig.shared.delegate?.showError(error: ConnError.unauthorized)
        //Forbidden
        case 403:
            STRConfig.shared.delegate?.showError(error: ConnError.forbidden)
        //Not Found
        case 404:
            STRConfig.shared.delegate?.showError(error: ConnError.notFound)
        //Request Timeout
        case 408:
            STRConfig.shared.delegate?.showError(error: ConnError.requestTimeout)
        //Internal Server Error
        case 500:
            STRConfig.shared.delegate?.showError(error: ConnError.internalServerError)
        //Bad Gateway
        case 502:
            STRConfig.shared.delegate?.showError(error: ConnError.badGateway)
        //Gateway Timeout
        case 504:
            STRConfig.shared.delegate?.showError(error: ConnError.gatewayTimeout)
            
        default:
            if let error = response.error {
                onError(error)
                return
            }
        }
    }
}

public extension STRService {
    
    public func execute(dispatcher: URLSessionNetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping (Any) -> Void,
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
