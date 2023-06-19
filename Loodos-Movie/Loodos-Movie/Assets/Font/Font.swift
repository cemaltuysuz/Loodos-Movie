//
//  Font.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import UIKit

class Font {
    static func font(_ fontType: FontType, size: CGFloat) -> UIFont {
        let customFont = UIFont(name: fontType.rawValue, size: size)
        return customFont ?? UIFont.systemFont(ofSize: size)
    }
}
