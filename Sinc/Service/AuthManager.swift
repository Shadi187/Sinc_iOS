//
//  AuthManager.swift
//  Sinc
//
//  Created by boshFbt on 22/06/2024.
//


//SESSION MANAGER

/*
 - WILL GENERATE THE CREDENTIALS FROM THE KEYCHAIN
 - STORE THE CREDS ON THE LOCAL VARIABLES WHEN IT'S THE FIRST TIME
 - GENERATE THE CREDS FOR THE FUNCTIONS
 */
import Foundation

class AuthManager {
//    @Published var isLoggedIn: Bool = UserDefaultManager.isLoggedIn()
    
    static let instance = AuthManager()
    
    @Published private var UserID:String = ""
    
    @Published var CurrentUser:User? = nil
    
    
    func saveCred(with registeredMethod:String,password:String) {
        UserDefaults.standard.setValue(true, forKey: "onBoarding")
        UserDefaults.standard.setValue(registeredMethod,forKey: "username")
        KeyChainManager.saveCred(for: registeredMethod, password: password)
    }
    
    
    func signOut(for registeredMethod:String){
        UserDefaults.standard.setValue(false, forKey: "onBoarding")
        UserDefaults.standard.removeObject(forKey: "username")
        KeyChainManager.deleteToken(for: registeredMethod)
         
    }
    
    func retriveInfo() async -> (Bool,[User]?){
        if let userName = UserDefaults.standard.string(forKey: "username") {
            if let password = KeyChainManager.retriveToken(for: userName) {
                do {
                    let cred = try await SupabaseManager.instance.checkUser(user: User(id: UUID().uuidString, username: userName, password: password, email: "", bio: "", imgUrl: "", createdAt: "",firstName:"",gender:"",dOb: ""))
                    UserID = cred.1?.first?.id ?? ""
                    CurrentUser = (cred.1?.first)!
                    
                    return cred
            }catch {
                    print("AUTHMANAGER- (ERROR GETTING THE USERCRED) ")
                    signOut(for: userName)
//                    return (false,nil)
                }
                
            }
        }
        
        
        return (false,nil)
    }
    
    
    func getTheID() async -> String? {
        if let userName = UserDefaults.standard.string(forKey: "username"){
            if let pss = await retriveInfo().1?.first {
                return pss.id
            }else {
                print("NO ID ")
                return nil
            }
        }else {
            print("NO USERNAME")
            return nil
        }
        
    }
    
    func getID() -> String {
        UserID
    }
    
    func setValueOfId(user:User){
        self.CurrentUser = user
    }
}
