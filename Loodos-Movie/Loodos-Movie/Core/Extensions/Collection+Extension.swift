//
//  Collection+Extension.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
