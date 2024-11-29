//
//  DefaultConfigManager.swift
//  backup
//
//  Created by Rahul Acharya on 29/11/24.
//

import Foundation

class DefaultConfigManager {
    /*
     DefaultConfigManager.shared.loadDefaultsFromPlist() // put in appdelegate
     let config = DefaultConfigManager.shared.getDefaultConfig() // put in vc
     print(config.color)  // Will print the color value from the plist (or default value if plist loading fails)
     print(config.isProUser)  // Will print the isProUser value
     */
    
    static let shared = DefaultConfigManager()
    
    var defaultConfig: DefaultConfigModel?
    
      func loadDefaultsFromPlist() {
          
          let decoder = PropertyListDecoder()
          
          guard let path = Bundle.main.path(forResource: "DefaultConfig", ofType: "plist"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
              print("Failed to load plist data")
              return
          }
          
          do {
              defaultConfig = try decoder.decode(DefaultConfigModel.self, from: data)
          } catch {
              print("Error decoding plist data: \(error.localizedDescription)")
          }
      }
      
    func getDefaultConfig() -> DefaultConfigModel {
        return defaultConfig ?? DefaultConfigModel(color: "", isProUser: false)
    }
}


// Default configuration model, conforms to Codable
struct DefaultConfigModel: Codable {
    let color: String
    let isProUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case color
        case isProUser = "pro_user"
    }
}
