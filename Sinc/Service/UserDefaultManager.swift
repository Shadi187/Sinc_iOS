//
//  UserDefaultManager.swift
//  Sinc
//
//  Created by boshFbt on 22/06/2024.
//

import Foundation

struct UserDefaultManager {
    static let isLoggedInKey = "isLoggedIn"
    
    static func setLoggedIn(_ loggedIn:Bool){
        UserDefaults.standard.set(loggedIn, forKey: isLoggedInKey)
    }
    
    static func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
}
