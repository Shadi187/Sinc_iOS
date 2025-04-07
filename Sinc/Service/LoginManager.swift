////
////  LoginManager.swift
////  Sinc
////
////  Created by boshFbt on 21/06/2024.
////
//
//import Foundation
//
//final class LoginManager: ObservableObject{
//    
//    @Published private var accountCredentials:User? = nil
//    
//    static let instance = LoginManager()
//    
//    func setAccountCredentials(user:User, signIn:Bool){
//        if signIn{
//            self.accountCredentials = user
//            UserDefaultManager.setLoggedIn(true)
//            print("the value of the onBoarding after changing it  = " , UserDefaults.standard.bool(forKey: "onBoarding"))
//            KeyChainManager.saveCred(token: "userDetails", for: "",user:user)
//            
//        }
//        else {
//            self.accountCredentials = nil
//            UserDefaultManager.setLoggedIn(false)
//            print("the value of the onBoarding after changing it  = " , UserDefaults.standard.bool(forKey: "onBoarding"))
//        }
//        
//    }
//    
//    
//    func getAccountCredentials()->User{
//        return accountCredentials!
//    }
//    
//    func getCred(){
//        print(KeyChainManager.retriveToken(for: ""))
//    }
//    
////    @Published var user = User(userid: nil, username: "", password: "", email: "", bio: "", imgUrl: "", createdAt: "")
//    
//    @Published var isLoggedIn:Bool = false
//    
//    @Published var user:User? = nil
//    
//    func changeUser(user:User) {
//        self.user = user
//    }
//    
//    func updateOnBoarding(){
//        UserDefaults.standard.setValue(true, forKey: "onBoarding")
//    }
//    
//    func deleteOnBoarding(){
//        UserDefaults.standard.setValue(false, forKey: "onBoarding")
//    }
//    
//
//}
