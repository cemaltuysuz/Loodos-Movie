//
//  UIImageView+Extension.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import UIKit

extension UIImageView {
    func setImage(from url: String?) {
        ImageLoader.load(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
                
            }
        }
    }
}


