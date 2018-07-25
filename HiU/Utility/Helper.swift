//
//  Helper.swift
//  HiU
//
//  Created by Shiny Solutions on 1/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

struct Fonts {
    static let Small = UIFont(name: "Nanami-Regular", size: 10)
    static let Medium = UIFont(name: "Nanami-Regular", size: 12)
    static let Large = UIFont(name: "Nanami-Regular", size: 14)
}

class Helper {
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        NSLog("%@", "Helper - UIColorFromRGB")
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
