//
//  SignupView.swift
//  Project1
//
//  Created by boshFbt on 14/04/2024.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var vm = SignupViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color.theme.ashGray.ignoresSafeArea()
            if vm.state == .credPhase{
                credPhase
                if vm.showSuccess{
                    if vm.lastResponse{
                        AddedSuccessfully()
//                        vm.dismissView()
                    }
                    
                }else {
                    
                }
                if vm.showFailure{
                        NotAdded()
                    
                }else {
                    
                }
            }else {
                personalData
            }
            
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupView()
}

extension SignupView {
    var Username: some View {
        VStack{
            TextField("", text: $vm.userName,prompt: Text("Username").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                .modifier(TextFieldViewModifier(condition: $vm.showErrors[0]))

            if vm.showErrors[0] {
                Text("user name should be more than 2 characters")
                    .foregroundStyle(Color.red)
            }
    }
}
    
    var Email: some View {
        VStack {
            TextField("", text: $vm.email,prompt: Text("Email").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                .modifier(TextFieldViewModifier(condition: $vm.showErrors[1]))
            
            if vm.showErrors[1] {
                    Text("Email is not correct")
                        .foregroundStyle(Color.red)
                
            }
        }
        
        
//                    .frame(height: 100)
    }
    
    var Password: some View {
        VStack {
            TextField("", text: $vm.password,prompt: Text("Password").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                .modifier(TextFieldViewModifier(condition: $vm.showErrors[2]))
                .overlay(
                    Image(systemName:vm.showPassword ? "eye.slash.fill" : "eye.fill")
                        .modifier(EyeFillViewModifier())
                        .onTapGesture {
                            withAnimation(.spring){
                                vm.showPassword.toggle()
                            }
                        }
                    ,alignment: .trailing
                )
            
                .overlay(
                    SecureField("", text: $vm.password,prompt: Text("Password").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                        .modifier(TextFieldViewModifier(condition: $vm.showErrors[2]))
    //                            .frame(height: 60)
                        .overlay(
                            Image(systemName:vm.showPassword ? "eye.slash.fill" : "eye.fill")
                                .modifier(EyeFillViewModifier())
                                .onTapGesture {
                                    withAnimation(.spring){
                                        vm.showPassword.toggle()
                                    }
                                }
                            ,alignment: .trailing
                        )
                        .opacity(!vm.showPassword ? 1 : 0)
            )
            if vm.showErrors[2]{
                Text("Password should be at least 5 characters long")
                    .foregroundStyle(Color.red)
            }
            
        }
    }

    
    var ConfirmPassword: some View {
        VStack {
            TextField("", text: $vm.confirmpassword,prompt: Text("Confirm password").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                .modifier(TextFieldViewModifier(condition: $vm.showErrors[3]))
   
                .overlay(
                    Image(systemName:vm.showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                        .modifier(EyeFillViewModifier())
                        .onTapGesture {
                            withAnimation(.spring){
                                vm.showConfirmPassword.toggle()
                            }
                        }
                    ,alignment: .trailing
                )
            
                .overlay(
                    SecureField("", text: $vm.confirmpassword,prompt: Text("Confirm Password").foregroundStyle(Color(uiColor:UIColor.lightGray)))
                        .modifier(TextFieldViewModifier(condition: $vm.showErrors[3]))
                        .overlay(
                            Image(systemName:vm.showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                .modifier(EyeFillViewModifier())
                                .onTapGesture {
                                    withAnimation(.spring){
                                        vm.showConfirmPassword.toggle()
                                    }
                                }
                            ,alignment: .trailing
                        )
                        .opacity(!vm.showConfirmPassword ? 1 : 0)
            )
            
            if vm.showErrors[3]{
                Text("The passwords not the same ")
                    .foregroundStyle(Color.red)
            }
        }
        
        
    }
    
    
    var RegisterButton: some View {
        Button(action:{
            vm.check()
            vm.isButtonPressed = true
            Task{
                
                do{
                    if vm.buttonAvailable{
                        
                        try await vm.enterUserCreds()
//                        print("Signed up successfully")
                    }
//                    print("Not signed up")
                    
                }catch{
                    vm.showLabel()
                    print("NOOOOO")
                }
            }
        }
    ,
        label:{
            RoundedRectangle(cornerRadius: 10)
                .modifier(ButtonViewModifier(text:"Register"))
        })
        
        
    }
    
    var SocialMedia: some View {
        HStack(spacing:20){
            Image("facebook")
                .resizable()
                .modifier(SocialMediaViewModifier())
            
            Image("apple")
                .resizable()
                .modifier(SocialMediaViewModifier())
            
            Image("google")
                .resizable()
                .modifier(SocialMediaViewModifier())
        }
        .padding(.top)
    }
    
    var credPhase: some View {
        VStack(spacing: 20){
            Image("BG")
                .resizable()
                .scaledToFit()
                .frame(width:200,height: 100)
            Username
            Email
            Password
            ConfirmPassword
            RegisterButton
            
            Divider()
                .overlay(
                    Text("Or Login with")
                        .foregroundStyle(Color.gray)
                        .padding()
                        .background(
                            Color.theme.ashGray
                        )
                    
                )
            
//            doesHveAnAccount
            SocialMedia
            //                DonHavePassword
            
            
        }
    }
    
    var personalData: some View {
        VStack(spacing:40){
            TextField("First Name", text: $vm.firstName)
                .modifier(TextFieldViewModifier(condition:$vm.isInputsValid[0]))
            
            chooseSex
                .padding()
            
            TextField("Bio", text: $vm.bio)
                .modifier(TextFieldViewModifier(condition: $vm.isInputsValid[1]))
            
            DatePicker("Birth date", selection: $vm.dOb,displayedComponents: .date)
                .padding()
            
            Button {
                Task {
                    let ss = try await vm.sendInfoToDB()
                    if ss{
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }label: {
                RoundedRectangle(cornerRadius: 10)
                    .modifier(ButtonViewModifier(text:"Complete Registration"))
            }
            
        }
    }
    
    var chooseSex: some View {
        HStack {
            Text("Choose your Sex")
                .bold()
                .font(.title3)
//                        .foregroundStyle(Color.white)
            Spacer()
            Picker("Gender", selection: $vm.gender) {
                ForEach(SignupViewModel.genderList.allCases){ option in
                    
                        Text(option.show)
                    
                        
                }.pickerStyle(.menu)
                    
            }.background(
                RoundedRectangle(cornerRadius:25)
                    .foregroundStyle(Color.white)
                    .frame(width:100,height:70)
                    
            )
            
            
            
        }
    }
    
//    var doesHveAnAccount: some View  {
//
//            Text("Have An Account")
//                .foregroundStyle(Color.theme.Cerulean)
//                .onTapGesture {
//                    self.updateRegisteration(true)
//                }
//
//    }
}

