//
//  SessionData.swift
//  IRUN
//
//  Created by VIDAL Léo on 14/07/2021.
//

import Foundation

class SessionData {
    static func setToken(token: String) {
        let userSettings = UserDefaults.standard
        userSettings.set(token, forKey: "Token")
    }
    
    static func getToken() -> String? {
        let userSettings = UserDefaults.standard
        guard let token = userSettings.object(forKey: "Token") as! String? else {
            return nil
        }
        return token
    }
}
