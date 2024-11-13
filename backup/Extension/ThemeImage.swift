//
//  ThemeImage.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation
import UIKit

enum ThemeImage: String {
    case test = "dummy"
    
    var getImage: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}
