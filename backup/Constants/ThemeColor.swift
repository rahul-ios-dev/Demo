//
//  ThemeColor.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation
import UIKit

enum ThemeColor: String {
    case red = "CustomRed"
    case green = "CustomGreen"
    case blue = "CustomBlue"
    case on1 = "on1"
    case on2 = "on2"
    case on3 = "on3"
    
    var getColor: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
}
