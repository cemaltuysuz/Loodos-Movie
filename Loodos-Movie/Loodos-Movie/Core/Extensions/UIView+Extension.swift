//
//  UIView+Extension.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import UIKit

extension UIView {
    static var makeClearContentView: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
    
    func changeVisibilityWithAnimation(isHidden: Bool, duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration) {
            self.isHidden = isHidden
        }
    }
}
