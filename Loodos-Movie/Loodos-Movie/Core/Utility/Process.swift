//
//  Process.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 25.06.2023.
//

import UIKit

class Process {
    private var indicatorView: UIView?
    
    public static let shared = Process.init()
        
    func show()
    {
        
        DispatchQueue.main.async {
            let indicator = UIActivityIndicatorView.init(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.tintColor = .colorPrimary
            indicator.startAnimating()
            
            guard let target = UIApplication.shared.keyWindow else {
                return
            }
            let backgroundview = UIView.init(frame: target.bounds)
            backgroundview.translatesAutoresizingMaskIntoConstraints = false
            backgroundview.backgroundColor = .colorPrimary.withAlphaComponent(0.5)
            target.addSubview(backgroundview)
            backgroundview.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            backgroundview.addSubview(indicator)
            
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            self.indicatorView = backgroundview
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.indicatorView?.removeFromSuperview()
            self.indicatorView = nil
        }
    }
}
