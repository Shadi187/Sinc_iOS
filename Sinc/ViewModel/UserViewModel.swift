//
//  UserViewModel.swift
//  Sinc
//
//  Created by boshFbt on 18/06/2024.
//

import Foundation
import SwiftUI
@MainActor
final class UserViewModel:ObservableObject {
//    @Published var isPressed: (Bool,Int) = (false,0)
    @Published var contentArray: [String] = ["New Posts", "For You", "Trending","All"]
    @Published var userInfo:User? = nil
    @Published var PostsList:[Posts] = []
    @Published var username:[String] = []
    
//    @Published var forPosts:{String:Posts}? = nil
    
    init() {
        Task{
            userInfo = await AuthManager.instance.retriveInfo().1?.first ?? AuthManager.instance.CurrentUser
            
            
//            self.PostsList = try await SupabaseManager.instance.getPosts(userId: "d0b59ef7-758b-4e07-8556-83fb6627a757")
     
            print("we started the user view model" )
            
            self.PostsList = try await SupabaseManager.instance.getPostsOfFollow(userId: userInfo?.id ?? "")
            
            
            print("IS IT EMPTY? ",PostsList.isEmpty)
            
            
        }
        
        
    }

    
    func signOut(){
        if let name =  userInfo?.username {
            AuthManager.instance.signOut(for: name)

        }
    }
    
    func getImage(url:URL) async -> UIImage? {
        await ImageManager.instance.fetchData(url: url.description)
    }
    
    
    
    
}


/*
 {
     didSet{
         Task{
             for k in PostsList{
                try await username.append(SupabaseManager.instance.getUserName(userId: k.userId.description))
                 
             }
         }
     }
 }
 */
