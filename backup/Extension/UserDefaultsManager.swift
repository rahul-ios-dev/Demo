//
//  UserDefaultsManager.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation

class UserDefaultsManager {
    
    private let userNameKey = "userName"
    
    // Save name to UserDefaults
    func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
    }
    
    // Retrieve name from UserDefaults
    func getName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
}
