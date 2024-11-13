//
//  CustomFont.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation
import UIKit

class CustomFont {
    static func font(style: CustomFontStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
}

enum CustomFontStyle: String {
    case extraLight = "PlaywriteGBS-ExtraLight"
    case extraLightItalic = "PlaywriteGBS-ExtraLightItalic"
    case italic = "PlaywriteGBS-Italic"
    case light = "PlaywriteGBS-Light"
    case lightItalic = "PlaywriteGBS-LightItalic"
    case regular = "PlaywriteGBS-Regular"
    case thin = "PlaywriteGBS-Thin"
    case thinItalic = "PlaywriteGBS-ThinItalic"
}
