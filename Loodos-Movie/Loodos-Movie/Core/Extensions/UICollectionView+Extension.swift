//
//  UICollectionView+Extension.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        let identity = String.init(describing: type.self)
        self.register(type, forCellWithReuseIdentifier: identity)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cellType: T.Type, indexPath: IndexPath) -> T {
        let identity = String.init(describing: cellType.self)
        return dequeueReusableCell(withReuseIdentifier: identity, for: indexPath) as! T
    }
}

extension UICollectionView {
    
    func showBannerMessage(message: String) {
        DispatchQueue.main.async {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = .colorPrimary
            label.font = Font.font(.cabinSemiBold, size: 17.0)
            label.text = message

            label.sizeToFit()

            self.backgroundView = label
        }
    }
    
    func clearBackground() {
        backgroundView = nil
    }
}
