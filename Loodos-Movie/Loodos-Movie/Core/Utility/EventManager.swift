//
//  EventManager.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 25.06.2023.
//

import Foundation
import FirebaseAnalytics

enum EventType: String {
    case movieViewed = "MovieViewed"
}

class EventManager {
    static let shared = EventManager()
    
    func event(type: EventType, value: String) {
        DispatchQueue.global().async {
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                AnalyticsParameterItemID: type.rawValue,
                AnalyticsParameterItemName: value
            ])
        }
    }
}
