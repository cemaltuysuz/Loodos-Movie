//
//  SplashVM.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import Foundation
import Network

class SplashVM: ViewModel {
    
    private var monitor: NWPathMonitor?
    private var isThereConnection: Bool = false
    
    private let waitingTimeSecond: Int = 3
    
    var onStateChanged: ((SplashVCState)-> Void)?

    func startMonitoringInternet() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            self.isThereConnection = path.status == .satisfied
        }
        monitor?.start(queue: .main)
    }
    
    func cancelMonitoring() {
        monitor?.cancel()
        monitor = nil
    }
    
    func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(waitingTimeSecond)) {
            let state: SplashVCState = self.isThereConnection ? .continueMoviesPage : .noInternetConnection
            self.cancelMonitoring()
            self.onStateChanged?(state)
        }
    }
}

// MARK: Flow Management
extension SplashVM {
    
    func enterFlow() {
        onStateChanged?(.monitoringStarted)
        startMonitoringInternet()
        startTimer()
    }
}
