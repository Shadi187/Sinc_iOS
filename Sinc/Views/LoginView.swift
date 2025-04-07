//
//  ContentView.swift
//  Project1
//
//  Created by boshFbt on 13/04/2024.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage("onBoarding") var onBoarding = false
    @EnvironmentObject var vm: LoginViewModel
//    @StateObject var vm2 = UserViewModel()
    
    
    
    var body: some View {
        
        
            
            ZStack{
                Color.theme.ashGray.ignoresSafeArea()
                
                VStack{
                    Image("BG")
                        .resizable()
                        .scaledToFit()
                        .frame(width:200,height: 100)
                    
                    usernameOrEmail
                    Password
                    ForgetPassword
                    LoginButton
                    
                    Text(vm.texxt)
                    
                    
                    
                    Divider()
                        .overlay(
                            Text("Or Login with")
                                .foregroundStyle(Color.gray)
                                .padding()
                                .background(
                                    Color.theme.ashGray
                                )
                            
                        )
                    
                    SocialMedia
                    DonHavePassword
                    
                    
                }
                
                if vm.isThereAccount{
                    AddedSuccessfully(content: "Signed In")
                }else if !vm.isThereAccount && vm.showFailure{
                    NotAdded(content: "Wrong Credentials")
                    
                }
                
                
            }
        }


    
}

struct LoginView_Preview: PreviewProvider {
    
    
    private static let vm = LoginViewModel()
    
    static var previews: some View{
        LoginView()
            .environmentObject(vm)
    }
}

extension LoginView{
    
    var usernameOrEmail: some View {
        TextField("", text: $vm.input,prompt: Text("Username Or Email").foregroundStyle(Color.gray))
            .modifier(TextFieldViewModifier(condition: $vm.showErrors[0]))
    }
    
//    var Email: some View {
//        TextField("Email", text: $vm.email)
//            .padding(.leading)
//            .padding(.leading)
//            .background(
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.white)
//                    
////                            .fill(Color.white)
//                    .frame(height:60)
//                    .padding()
//                    
//            )
//            .padding(.leading)
//            .padding(.trailing)
//                    .frame(height: 100)
//    }
    
    var Password: some View {
        TextField("", text: $vm.password,prompt: Text("Password").foregroundStyle(Color.gray))
//            .padding()
            .modifier(TextFieldViewModifier(condition: $vm.showErrors[1]))
        
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
                SecureField("", text: $vm.password,prompt: Text("Password").foregroundStyle(Color.gray))
                        .modifier(TextFieldViewModifier(condition: $vm.showErrors[1]))
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
    }
    
    var ForgetPassword: some View {
        HStack{
            Spacer()
            Text("Forgot Password?")
                .foregroundStyle(Color.gray)
                 
        }.padding(.trailing)
    }
    
    var LoginButton: some View {
        
        Button {
            
            vm.isLoggedIn = true
            
            Task{
                try await vm.checkInputs()
                
                print(vm.isThereAccount)
            }
        } label: {
            
                RoundedRectangle(cornerRadius: 10)
                    .modifier(ButtonViewModifier(text:"Login"))
            

            
        }
//            .onTapGesture {
//                
//            }
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
    
    var DonHavePassword: some View {
        HStack {
            Text("Don't have an account")
            NavigationLink(destination: SignupView()) {
                Text("Register Now ")
                    .foregroundStyle(Color.theme.Cerulean)
                
            }
            
        }
    }
}


/*
 Button{
     
//                do{
//                    var   vr: User = try await vm.getData().execute().value
//                    print("\(vr.self)")
//                }catch{
//                print("Error in login View")
//                }
         
//                await vm.sendData()
         Task{
             do{
                 try await vm.signIn()
                 
                 if vm.texxt == "there is account"{
                     NavigationLink(destination: UserView(user: User(userid: 2, username: vm.username, pwd: vm.password, email: vm.email))) {Text("dsadas")}
                 }
                 
                 
                 print(vm.texxt)
             }catch{
                 print("error.localizedDescription")
             }
         }
     
 }label:{
     RoundedRectangle(cornerRadius: 10)
         .padding()
         .frame(width:390,height:100)
         .foregroundStyle(Color.theme.richBlack)
         .overlay(
             Text("Login")
                 .foregroundStyle(Color.white)
                 .bold()
         )
 }
 */
