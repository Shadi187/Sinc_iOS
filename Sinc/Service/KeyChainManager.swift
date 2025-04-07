//
//  KeyChainManager.swift
//  Sinc
//
//  Created by boshFbt on 21/06/2024.
//

import SwiftUI
import Security
import KeychainAccess


/*
 1- REGISTER
 2- SIGNIN
 3- SYNC1-> WILL SAVE THE CREDENTIALS ON THE CLOUD
 4- SYNC2-> USERDEFAULTS TO PERSIST THE DATA
 */


struct KeyChainManager {
    static let instance = KeyChainManager()
    
//    static let serviceName = "FBT.C.Sinc"
    
    static func saveCred(for registeredMethod:String,password:String){
//        let data = token.data(using: .utf8)
        if let pssData = password.data(using: .utf8){
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String:registeredMethod,
            kSecValueData as String: pssData
        ]
        
        let status = SecItemAdd(query as CFDictionary,nil)
            
            if status != errSecSuccess {
                print("ERROR STORING CREDENTIALS IN KEYCHAIN: \(status)")
            }
        }
    }
    
    
    static func retriveToken(for account:String) -> String? {
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item:CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let data = item as? Data, let token = String(data:data,encoding: .utf8){
                return token
            }
        }
        return nil
    }
    
    static func deleteToken(for account:String) {
        let query:[String:Any] = [
            kSecClass as String:kSecClassGenericPassword,
//            kSecAttrService as String:serviceName,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
    
}
