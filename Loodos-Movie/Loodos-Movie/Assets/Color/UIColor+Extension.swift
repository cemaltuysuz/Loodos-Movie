//
//  Color.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import UIKit

public extension UIColor{
    
    static var colorPrimary: UIColor{
        black600
    }
    
    static var colorSecondary: UIColor{
        gray500
    }
    
    static var colorBackground: UIColor{
        gray100
    }
    
    static var gray100: UIColor{
        UIColor(named: Color.gray100.rawValue)!
    }
    
    static var gray500: UIColor{
        UIColor(named: Color.gray500.rawValue)!
    }
    
    static var black600: UIColor{
        UIColor(named: Color.black600.rawValue)!
    }
}
