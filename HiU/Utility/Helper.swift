//
//  Helper.swift
//  HiU
//
//  Created by Shiny Solutions on 1/11/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class Helper {
    
    private static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        NSLog("%@", "Helper - UIColorFromRGB")
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func appThemeColor() -> UIColor {
        return UIColorFromRGB(rgbValue: 0xcf00d2)
    }
    
    static func appThemeGray() -> UIColor {
        return UIColorFromRGB(rgbValue: 0xbfbfbf)
    }
    
    static func appThemeBlack() -> UIColor {
        return UIColorFromRGB(rgbValue: 0x16262f)
    }
}

extension UIFont{
    private static func customFont(name: String, size: CGFloat) -> UIFont{
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func appFontVeryLarge() -> UIFont{
        return customFont(name: "Nanami", size: 18.0)
    }
    
    static func appFontLarge() -> UIFont{
        return customFont(name: "Nanami", size: 16.0)
    }
    
    static func appFontMedium() -> UIFont{
        return customFont(name: "Nanami", size: 12.0)
    }
    
    static func appFontSmall() -> UIFont{
        return customFont(name: "Nanami", size: 8.0)
    }
}
