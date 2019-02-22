//
//  STRConfig.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation

public protocol STRDelegate {
    func errorHandler(error: Error?)
}


struct Config {
    var shouldRecallWhenExpire: Bool = false
}


public class STRConfig {
    
    var config : Config? = nil
    
    var delegate: STRDelegate?
    
    
    
    
    func setupSTRService(config : Config) {
        self.config = config
        STRNetworkManager.shared.setupNetwork()
    }
    
    
    
    
    
}
