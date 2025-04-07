//
//  ViewModel.swift
//  Sinc
//
//  Created by boshFbt on 25/04/2024.
//

import Foundation
import Supabase

class ViewModel:ObservableObject{
    
    @Published var users:[User] = [
        //        User(queryValue: "dasda", userid: 1, password: "dsad", username: "sada", pwd: "dsadas", email: "fake")
    ]
    @Published var ss:User?
    
    //    @Published var user:User = User(userid:55, username: "", pwd: "dasdsa", email: "")
    init()  {
        Task{
//            await getData()
        }
        
        Task{
            do {
                //                self.user = try await SupabaseManager.instance.getUser()
            }catch{
                print("ERRROR")
            }
            
        }
        
    }
    
    //    func getData() async -> PostgrestFilterBuilder {
    ////        var tempUser:[User] = [User(userid:21, username: "ssss", pwd: "DSADSA", email: "")]
    //        do{
    //            let query = try await SupabaseManager.instance.client
    //                .from("User")
    //                .select()
    //                .eq("name",value:"shadi187")
    //
    //
    //            return query
    //
    
    //            return query
    
    //        }catch{
    //            print("error")
    //        }
    //
    //    }
    //
    //    func sendData()async {
    //        let sendableQuery = User(userid:2,username: "shadi2", pwd: "11221", email: "sadasda@gmail.com")
    //        do{
    //        let query =  try await SupabaseManager.instance.client
    //            .from("User")
    //            .insert(sendableQuery)
    //            .execute()
    //            .value
    //
    //        }catch{
    //            print("ERROR IN SENDING")
    //
    //        }
    //    }
    //}
    //
    //
    //
}
