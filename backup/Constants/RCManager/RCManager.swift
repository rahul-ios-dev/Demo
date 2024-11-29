//
//  RCManager.swift
//  backup
//
//  Created by Rahul Acharya on 29/11/24.
//

import Foundation
import FirebaseRemoteConfig

class RCManager {
    
    // Singleton instance
    static let shared = RCManager()
    
    private let remoteConfig: RemoteConfig
    
    // A variable to store the config values in the model
    var remoteConfigModel: RemoteConfigModel?
    
    private init() {
        // Initialize the RemoteConfig instance
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        // Set default values from plist
        self.remoteConfig.setDefaults(fromPlist: "DefaultConfig")
    }
    
    // Fetch and activate remote config
    func fetchRemoteConfig(completion: @escaping (Bool, Error?) -> Void) {
        remoteConfig.fetch(withExpirationDuration: 60) { [weak self] status, error in
            if status == .success {
                print("Remote config values fetched successfully")
                self?.remoteConfig.activate { changed, error in
                    if changed {
                        print("Remote config values were updated.")
                    }
                    // Call the completion handler to notify success
                    self?.applyRemoteConfigValues()
                    completion(true, nil)
                }
            } else {
                print("Error fetching remote config values: \(String(describing: error))")
                completion(false, error)
            }
        }
    }
    
    // Apply fetched remote config values and store them in the model
    func applyRemoteConfigValues() {
        let isFeatureEnabled = remoteConfig["isFeatureEnabled"].boolValue
        let appBackgroundColor = remoteConfig["appBackgroundColor"].stringValue
        
        // Store these values in the model
        self.remoteConfigModel = RemoteConfigModel(
            isFeatureEnabled: isFeatureEnabled,
            appBackgroundColor: appBackgroundColor
        )
    }
}

// Define the model to store remote config values
struct RemoteConfigModel {
    var isFeatureEnabled: Bool
    var appBackgroundColor: String
}
