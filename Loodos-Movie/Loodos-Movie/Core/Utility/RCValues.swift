//
//  RCValues.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation
import Firebase

class RCValues {
    static let notificationKey: String = "RCValueNotify"
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
        remoteConfig.fetchAndActivate { status, error in

            if let error = error {
                print ("Got an error fetching remote values \(error)")
                return
            }

            NotificationCenter.default.post(name: NSNotification.Name(RCValues.notificationKey), object: nil)
        }
    }
    
    func getValue(from key: String) -> RemoteConfigValue {
        return remoteConfig.configValue(forKey: key)
    }
}
