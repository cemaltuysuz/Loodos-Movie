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
