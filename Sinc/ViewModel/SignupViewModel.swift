//
//  SignupViewModel.swift
//  Project1
//
//  Created by boshFbt on 14/04/2024.
//

import Foundation
import Combine
import SwiftUI

final class SignupViewModel:ObservableObject {
    enum registerState {
        case credPhase,personalPhase,loginPhase
    }
        
    enum genderList:String,Identifiable,CaseIterable {
        case male,female
        
        var id: Self  {self}
        
        var show:String {
            switch self {
            case .male:
                return "👨🏿‍🔬 Male"
            case .female:
                return "👩🏿‍🔬 Female"
            
            }
        }
        
        var description:String {
            switch self {
                case .male:
                    return "Male"
                case .female:
                    return "Female"
            }
        }
        
    }
    
    //MARK: Account Details Variables
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var confirmpassword: String = ""
    @Published var firstName:String = ""
    @Published var bio: String = ""
    @Published var dOb: Date = .now
    @Published var gender:genderList = .male
    
    //MARK: Conditional Statements Variables
    @Published var showPassword: Bool = false
    @Published var showConfirmPassword:Bool = false
    @Published var isInputsValid = [false,false,false,false] {
        didSet {
            if isButtonPressed {
                check()
                checkInputs()
            }
            checkInputs()
            
        }
    }
    
    
    @Published var state:registerState = .credPhase
    
    @Published var isButtonPressed = false
    
    @Published var showErrors = [false,false,false,false]
    
    @Published var buttonAvailable:Bool = false
    
    @Published var showSuccess:Bool = false
    
    @Published var lastResponse = false
    
    @Published var showFailure:Bool = false
    
    private var cancellableSet = Set<AnyCancellable>()

    //MARK: CHECK INPUTS
    
    init(){
        $userName
            .map{ word in
                return word.count > 1
            }
            .assign(to:\.isInputsValid[0],on:self)
            .store(in: &cancellableSet)
        
        $email
            .map{ email in
                return email.contains("@") && email.contains(".com")
            }
            .assign(to:\.isInputsValid[1],on:self)
            .store(in: &cancellableSet)
        
        $password
            .map{ password in
                return password.count > 4
            }
            .assign(to: \.isInputsValid[2],on:self)
            .store(in: &cancellableSet)
        
        $confirmpassword
            .map{confPas in
                return confPas == self.password
            }
            .assign(to:\.isInputsValid[3],on:self)
            .store(in: &cancellableSet)

    }
    
    //MARK: FUNCTIONS
    func enterUserCreds() async throws {
        
        if try await SupabaseManager.instance.checkUserForRegister(email:self.email,username: self.userName){
            withAnimation(Animation.easeIn(duration: 0.2)) {
                state = .personalPhase
            }
            
            
            
            
        }else {
            print("Response is false")
        }
    }
    
    @MainActor func sendInfoToDB()async throws -> Bool{
        let tempUser = User(id: UUID().uuidString, username: self.userName, password: self.password, email: self.email, bio: self.bio, imgUrl: "", createdAt: Date.now.description, firstName: self.firstName, gender: gender.description, dOb: dOb.description)
        
        
        
        let response = try await SupabaseManager.instance.signUp(user: tempUser)
        
        if response {
            withAnimation(Animation.smooth(duration:0.5)) {
                showSuccess.toggle()
            }
            
            hideLabel()
            
            withAnimation(Animation.smooth(duration:0.5)) {
                state = .loginPhase
            }
            
//            dismissView()
            
        }else {
            print("There is error")
        }
        self.lastResponse = response
        return response
    }
    
    
    
    func checkInputs()  {
        self.buttonAvailable =  isInputsValid[0] && isInputsValid[1] && isInputsValid[2]
    }
    
    func showError(){
        for i in 0...3  {
            self.showErrors[i] = !(self.isInputsValid[i])
        }
//        print("showError[0] = \(showErrors[0])")
    }
    
    func check() {
        showError()
    }
    
    func hideLabel(){
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.6){
            withAnimation(Animation.smooth()) {
                self.showSuccess.toggle()
                
            }
        }
    }
    
    func showLabel() {
        withAnimation(Animation.smooth(duration:0.5)) {
            self.showFailure.toggle()
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8){ [self] in
            hideLabel1()
        }
        
        
       
    }
    
    func hideLabel1() {
        withAnimation(Animation.smooth(duration:0.5)) {
            self.showFailure.toggle()
            
        }
    }
    
    func EmptyInputs(){
        self.userName.removeAll()
        self.email.removeAll()
        self.password.removeAll()
        self.confirmpassword.removeAll()
        
        
    }
    
    @MainActor func changePref(){
        
    }
    
    
}
