


import Foundation


class AccountViewModel:ObservableObject {
    @Published var userPosts:[Posts] = []
    private var userId:String = ""
    
    init(){
        Task{
            userId = await AuthManager.instance.retriveInfo().1?.first?.id ?? ""
            await getPosts()
        }
        
        
    }
    
    func getPosts() async {
        print("WE ENTERED getPosts() FUNCTION")
        do{
            
                self.userPosts = try await SupabaseManager.instance.grabUserOwnPosts(userId: userId)
                print("userposts count ==",userPosts.count)
            }catch{
                print(error.localizedDescription)
            }
            
        }
}

