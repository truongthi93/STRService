//
//  STRConfig.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation

public struct Config {
    var shouldRecallWhenExpire: Bool = false
    
    public init(){}
}

public protocol STRDelegate {
    func showError(error: Error?)
    func getConfig() -> Config
}

extension STRDelegate {
    func setupSTR(delegate:STRDelegate) {
        STRConfig.shared.setupSTRService(config: self.getConfig(), delegate: delegate)
    }
}

public class STRConfig {
    
    public static let shared : STRConfig = {
        let instance = STRConfig()
        return instance
    }()
    
    var config : Config?
    
    var delegate: STRDelegate?
    
    public func setupSTRService(config : Config,delegate:STRDelegate) {
        self.config = config
        self.delegate = delegate
        STRNetworkManager.shared.setupNetwork()
    }
}

