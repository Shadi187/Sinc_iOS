//
//  SincApp.swift
//  Sinc
//
//  Created by boshFbt on 25/04/2024.
//

import SwiftUI

struct stateOfLog:PreferenceKey {
    static var defaultValue:Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


@main
struct SincApp: App {
    @StateObject var vm = LoginViewModel()
    @StateObject var vm2 = SignupViewModel()
    @StateObject var vm3 = UserViewModel()
    @AppStorage("onBoarding") var onBoarding = false
    @State var hasRegistered:Bool = true
    
    init(){
        Task{
            await AuthManager.instance.retriveInfo()
        }
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                        if !onBoarding{
                
                //                    if hasRegistered {
                LoginView()
                    .environmentObject(vm)
                
                
                                    }
                
                                    else {
                                        UserView()
                                            .environmentObject(vm3)
                                    }

                
                
            }
        }
    }
    
    
}


/*
 
 
 
 */
