//
//  RCValues.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation
import Firebase

class RCValues {
    
    static let sharedInstance = RCValues()
    private var remoteConfig: RemoteConfig!
    
    
    private init() {
        setRemoteConfig()
        loadDefaultValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            "splashTitle": "Loodos"
        ]
        remoteConfig.setDefaults(appDefaults as? [String: NSObject])
    }
    
    private func setRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func fetch() {
        remoteConfig.fetch()
    }
    
    func getValue(from key: String) -> RemoteConfigValue {
        return remoteConfig.configValue(forKey: key)
    }
}
