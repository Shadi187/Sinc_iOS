//
//  LoginViewModel.swift
//  Project1
//
//  Created by boshFbt on 14/04/2024.
//

import Foundation
import SwiftUI

@MainActor
final class LoginViewModel:ObservableObject{
    @Published var input:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var username:String = ""
    @Published var isThereAccount: Bool = false
    @Published var texxt:String = ""
    @Published var showPassword:Bool = false
    @Published var isInputsValid:[Bool] = [false,false]
    @Published var showFailure:Bool = false
    @Published var isLoggedIn:Bool = false
    @Published var showErrors:[Bool] = [false,false]
     
    //    func signIn() async throws{
    //        try await SupabaseManager.instance.signinUser(email: self.email, password: self.password)
    //    }
    typealias client = SupabaseManager
    
    init(){
        
    }
    
    func signIn(checkEmail:Bool)async throws {
        do {
            let boolen = checkEmail ? try await client.instance.checkUser(user: User(id: UUID().uuidString, username: "", password: self.password, email: self.email, bio: "",imgUrl:"", createdAt:"",firstName:"",gender:"", dOb: "")) :
            try await client.instance.checkUser(user: User(id: UUID().uuidString, username:self.username, password: self.password, email:"", bio: "",imgUrl:"", createdAt:"",firstName:"",gender:"", dOb: ""))
            if boolen.0 {
                self.texxt = "no account"
                withAnimation(Animation.spring(duration:0.5)){
                    self.showFailure = true
                }
                
                hideFLabel()
                
                self.isThereAccount = false
                
                
                
            }else {
                self.texxt = "there is account"
                withAnimation(Animation.spring(duration:0.5)){
                    isThereAccount.toggle()
                }
                
                //THERE IS AN ACCOUNT SO WHAT WE HAVE TO DO IS TO DOWNLOAD THE DATA AND STORE IT ON KEYCHAIN
                
                
                
                hideLabel()
                self.isThereAccount = true
                if let psValid = boolen.1?.first {
                    AuthManager.instance.saveCred(with: psValid.username, password: psValid.password)
                    AuthManager.instance.setValueOfId(user: (boolen.1?.first)!)
                    
                }
                //                print(2)
                //                print(boolen.0)
            }
        }catch{
            print("Error from signIn func-> ",error)
        }
        //        print("we reached before the boolean")
        
    }
    
//    func signIn(email)
    
    func checkInputs() async {
        if self.input.contains("@") && self.input.contains(".com") {
            self.email = self.input
            do {
                try await signIn(checkEmail: true)
                print("It's an email")
            }catch{
                print("It's email and there is error")
            }
            
        }else {
            self.username = self.input
            do {
                try await signIn(checkEmail: false)
                print("it's a username")
            }catch{
                print("It's username and there is error")
            }
        }
    }
    
    
    func hideFLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            withAnimation(Animation.spring(duration:0.5)){
                self.showFailure = false
            }
        }
        
        
    }
    
    func hideLabel(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            withAnimation(Animation.spring(duration:0.5)){
                self.isThereAccount.toggle()
            }
        }
    }
    
    //    func signOut() {
    //        LoginManager.instance.deleteOnBoarding()
    //    }
    //
    //
    //
    //    func getCred(){
    //        LoginManager.instance.getCred()
    //    }
}


/*
 
 
 func signiN()async throws -> Bool{
 return try await SupabaseManager.instance.singIn(email: "dsadsa", password: "dasdsad")
 }
 
 
 
 
 */
