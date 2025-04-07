//
//  Supabase.swift
//  Sinc
//
//  Created by boshFbt on 25/04/2024.
//

import Foundation
import Supabase
import Combine

final class SupabaseManager{
    static let instance = SupabaseManager()
    
    let client = SupabaseClient(supabaseURL: URL(string:"https://anuuefqevmtzytqvuqtl.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFudXVlZnFldm10enl0cXZ1cXRsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxNDA1ODE4NSwiZXhwIjoyMDI5NjM0MTg1fQ.G0CKfnAfhxmJjg-YMWjZd_7qgFpbhjMVRZHUuWy0Ec8")
    
    func signupUser(email:String, password:String) async {
        
        do {
        try await client.auth.signUp(email: email, password: password)
        }catch{
            print("ERRORR SIGNUP")
        }
    }
    
    
    
    //MARK: USER SIGN-IN/UP/OUT
    func signinUser(email:String,password:String) async {
        do {
            try await client.auth.signIn(email: email, password: password)
        }catch{
            print("ERROR SIGNING IN ")
        }
    }
    
    
    func getUser(user:User)async throws ->User {
        let response = try await client.from("users").select().in("email",values:[user.email]).execute()
        let decoder = JSONDecoder()
        return try (decoder.decode([User].self, from: response.data)).first!
        
        
    } 
    
    
    func checkUser(user:User) async throws -> (Bool,[User]?){
//        var isAccountRegistered = false
        
        let tempUser = user
        
        if tempUser.username == "" {
          do {
              let query = client.from("users").select().in("email", values: [tempUser.email])
            let query2 = query.in("pwd", values: [tempUser.password])
            
            let response = try await query2.execute()
            
            let decoder = JSONDecoder()
            
            let usera = try (decoder.decode([User].self, from: response.data).isEmpty,decoder.decode([User].self, from: response.data))

//              print("userDetails -> " , usera.1)
//              print("isThereUser from SupabaseManager -> " , usera.0)
              
//              AuthManager.instance./*username*/ = usera.1.first?.username ?? ""
              
            return usera
        }catch{
            throw error
        }
        }
        
        else {
        do {
            print(tempUser.username)
            let query = client.from("users").select().in("username", values: [tempUser.username])
            let query2 = query.in("pwd", values: [tempUser.password])
            
            let response = try await query2.execute()
            
            let decoder = JSONDecoder()
            
            let usera = try (decoder.decode([User].self, from: response.data).isEmpty,decoder.decode([User].self, from: response.data))
//            print("userDetails -> " , usera.1)
//            print("isThereUser from SupabaseManager -> " , usera.0)
//            print(usera.0)
//            return usera.isEmpty ? false : true
//            AuthManager.instance.username = usera.1.first?.username ?? ""
            return usera
        }catch{
            throw error
        }
    }
        
    }
    
    func checkUserForRegister(email:String,username:String) async throws -> Bool {

        do {
            //CHECK IF THE EMAIL IS THERE ALREADY
            let query = try await client.from("users").select("email").in("email",values:[email]).execute()
            let decoder = JSONDecoder()
            let result = try decoder.decode([User].self, from: query.data).isEmpty
            // IF THE EMAIL IS NOT IN THE DATABASE THEN CHECK FOR THE USERNAME
            if result {
                let query = try await client.from("users").select("username").in("username",values:[username]).execute()
                let result = try decoder.decode([User].self, from: query.data).isEmpty
//                print("We reached here result is true")
                return result ? true : false
            }
            else {
                return false
            }
        }catch{
            print("checkUserForRegister-> We reached here")
            throw error
        }
    }
    
//    func signIn() {
//        
//    }
//    
    func signUp(user:User) async throws -> Bool {
        do{
        
        let query = try await client.from("users").insert(user).execute()
            print(query.response)
        if (query.status > 200) && (query.status < 300) {
            print(query.status)
            return true
        }else {
            return false
        }
        }catch {
//            print(":")
            print(error.localizedDescription)
            return false
        }
    }
    
    func getPosts(userId:String)async throws->[Posts] {
        do {
        let query = try await client.from("posts")
                    .select()
                    .equals("user_id", value: userId)
//                    .containedBy("user_id", value: userId)
                    .execute()
        let decoder = JSONDecoder()
        let result = try decoder.decode([Posts].self, from: query.data)
//            print(result.first?.content ?? "Nothing")
        return result
        }catch{
            print(error.localizedDescription)
        }
        return []
    }
    
    func getUserName(userId:String)async throws -> String {
        do {
            let query = try await client.from("users").select().equals("user_id", value: userId.description.lowercased()).execute()
        
        let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([User].self, from: query.data)
                return result.first?.username ?? "Error"
                
            }catch{
                print("error from decoder",error)
                return "Error"
            }
        
            
            
            
        }catch{
            print("error from getUserName Function: ",error.localizedDescription)
            return "Error"
        }
        
    }
    
    
    func getUserImg(userId:String)async throws -> String {
        do {
            let query = try await client.from("users").select().equals("user_id", value: userId.description.lowercased()).execute()
        
        let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([User].self, from: query.data)
                return result.first?.imgUrl ?? "Error"
                
            }catch{
                print("error from decoder",error)
                return "Error"
            }
        
            
            
            
        }catch{
            print("error from getUserName Function: ",error.localizedDescription)
            return "Error"
        }
        
    }
    
    
    func getAllPosts()async throws -> [Posts]{
        do{
            let query = try await client.from("posts").select().execute()
            
            do {
            return try JSONDecoder().decode([Posts].self, from: query.data)
                
            }catch{
                print("from getAll Posts",error.localizedDescription)
                return []
            }
            
        }catch{
            print(error.localizedDescription)
            return []
        }
        
    }
    
    
    func searchUsers(text:String) async throws -> [String] {
        do {
            let query = try await client.from("users").select().textSearch("username", query: text).execute()
            print("text is: ",text)
            var res =  try JSONDecoder().decode([User].self,from:query.data)
            return res.map { User in
                User.username
            }
            
        }catch {
            print(error)
            return []
        }
    }
    
    func realSearchUsers(text:String) async throws -> [User] {
        do{
            let qu = try await client.from("users").select().ilike("username", pattern: "%\(text)%").execute()
//            print("text is: ",text)
            return try JSONDecoder().decode([User].self,from:qu.data)
            
        }catch{
            print(error)
            return []
        }
    }
    
    
    @MainActor func getPostsOfFollow(userId:String)async throws -> [Posts] {
       var postsList:[Posts] = []
        let myGroup = DispatchGroup()
//        var accounts:[String] = []
        do{
            let quer1 = try await client.from("follows").select("followee_id").equals("follower_id", value: userId).execute()
            var ss:[String] = []
            //Here We Got the IDs of the users we want to show their posts
            var rr = try JSONDecoder().decode([[String:String]].self, from: quer1.data)
//            print(rr.count)
            var kk = rr.map { di in
                di.mapValues { s in
                    ss.append(s)
                }
            }
//            print(ss.count)
            
            for item in ss {
//                myGroup.enter()
                print(item)
                let quer2 = try await client.from("posts").select().equals("user_id", value: item).execute()
                do{
                    var result = try JSONDecoder().decode([Posts].self, from: quer2.data).map { post in
                        postsList.append(post)
                    }
                    
                }catch{
                    ("From Decoder",error.localizedDescription)
                }
            }
            
            return postsList
            
            
            
            
            
            
            //Get the Posts using the usersID We Got
            print("The posts List count is \(postsList.count)")
            
            
        }catch{
            print(error)
        }
        
        return[]
    }
    
    func getFollowersPosts(usersIDs: String) async throws -> Posts? {
        do{
            let quer1 = try await client.from("posts").select().eq("user_id", value: usersIDs).execute()
            let res = try JSONDecoder().decode([Posts].self, from: quer1.data).first
            if let res {
                
                return res
            }else {
                return nil
            }
            
        }
        catch{
            print("from getFollowersPosts: " , error)
        }
        
        return nil
    }
    
    func downloadPhotosOfPosts(url:String) async throws -> Data?  {
        do {
            let data = try await client.storage.from("uploads").download(path:"\(url.components(separatedBy: "/"))")
            return data
        }catch{
            print(error)
            return nil
        }
    }
    
    
    func mockDownload(path:String)async throws -> Data? {
        do{
            print("path is",path.split(separator: "/")[1])
            let jj = try await client.storage.from("uploads").download(path: String(path.split(separator: "/")[1]))
            print(jj)
            
            return jj
            
        }catch{
            print(error)
            return nil
        }
        
        
//        print(rr)
    }
    
    
    func sendPost(userId:String,data:Data,content:String)async throws{
        
        do {
            try await sendPhoto(data: data)
        }catch{
            print(error)
            return
        }
        
//        let Post = Posts(id: UUID().uuidString, userId: userId, content: content, imgURL: <#T##String?#>, createdAt: <#T##String#>, updatedAt: <#T##String#>)
        
//        client.from("posts").insert()
    }
    
    
    
    func sendPhoto(data:Data)async throws{
        let fileName:String = UUID().uuidString
        do{
            let dd = try await client.storage.from("uploads").upload(path: "UsersPics/\(fileName)", file: data)
        }catch{
            print("ERROR FROM sendPhoto func the error is ⬇️")
            throw error
        }
    }
    
    
    
    func mockUpload(img:Data)async throws -> String{
        let fileName:String = "\(UUID().uuidString)"
        do{
            
            // When we use the components it will give us 2 outputs the characters before the character we should seperate from
            // and the characters after that why we used [1] here
            
            let ss = try await client.storage.from("uploads").upload(
                path: "\(fileName).jpg",
                file: img
                
            ).components(separatedBy: "/")[1]
            print("ss = ",ss)
            return ss
        }catch{
            print("ERROR FROM mockUplaod func the error is")
            throw error
        }
//        return ""
    }
    
    func createPost(userId:String,content:String,img:Data) async throws {
//        let url = try await mockUpload(img: img)
        
        do {
            let result = try await client.from("posts").insert(
                Posts(id: UUID(), userId: userId,
                      content: content,
                      imgURL: mockUpload(img: img) , createdAt: "06/25/2024", updatedAt: "06/25/2024")).execute().response
            
            print(result.statusCode)
        }catch{
            print(error)
        }
        
        
    }
    
    func grabUserOwnPosts(userId:String) async throws -> [Posts]{
        do{
            let query = try await client.from("posts").select().eq("user_id", value: userId).execute()
            let result = try JSONDecoder().decode([Posts].self, from: query.data)
            return result
        }catch{
            throw error
        }
    }
    
    
    func listenToChanges()async {
        
    }
}

//    func getUsersForPosts(quer:PostgrestResponse<Void>) -> [User] {
//        do{
////            let quer2 = quer.data
////            let
//        }catch{
//
//        }
//    }
    
    
//    func getUsernamesOFUsers(pso:[Posts]) async throws {
//        do {
//            let qr = try await client.from("users").select("username").in("user_id", values: [pso.first?.userId]).execute()
//            do{
//                var js = try JSONDecoder().decode([String:String].self,from:qr.data)
//                print(js.count)
//            }catch{
//                print("from getUsernamesOFUsers -Decoder- -> ",error)
//            }
//        }catch{
//            print("from getUsernamesOFUsers-> ",error)
//        }
//    }



//
//func jsonDecoder(input:PostgrestFilterBuilder) -> User {
//        let decoder = JSONDecoder()
//        let data = decoder.decode(User.Type, from: Data)
//    }

/*             var temp:[User] = try await SupabaseManager.instance.client
 .from("User")
 .select()
 .execute()
 .value
print("Downloaded Successfully")
 
 
 
*/



/*
 .map { Dict in
     Dict.mapValues { val in
         print("value is: ",val)
         
     }
     
     
 }
 */


/*
 - First we take the photo and upload it to the Storage and we store the name of the file and return it
 - We Store the name of the file in the Posts
 - Upload it
 -
 
 */
