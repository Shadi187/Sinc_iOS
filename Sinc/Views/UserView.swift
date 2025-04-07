//
//  UserView.swift
//  Sinc
//
//  Created by boshFbt on 18/06/2024.
//



import SwiftUI

//let user = User(userid: 1, username: "12sss", pwd: "12213", email: "213213@dksakd.com")

struct UserView: View {
//     var user:User
    var tempuRL:URL = URL(string:"https://www.animationmagazine.net/wordpress/wp-content/uploads/Netflix-One-Piece-Avatar.jpg")!
    var contentArray:[String] = ["New Posts", "For You", "Trending","All"]
    @EnvironmentObject var vm : UserViewModel
    @StateObject var vmForAccView =  AccountViewModel()
    var body: some View {
        
        TabView {
            
            Group{
                
                ZStack{
                    Color.theme.ashGray.ignoresSafeArea()
                    
                    ScrollView {
                        
                        VStack(spacing:6){
                            //Navbar
                            navBar
                            
                            //Filters
                            Filters
                            Divider()
                            //Stories
                            Stories
                            Divider()
                            
                            //Posts
                            
                            VStack(spacing:40){
                                
//                                    ForEach(vm.PostsList){thing in
//                                            
//                                        Post(profileName: vm.username, content: thing.content)
//                                        
//                                        
//                                    }
//                                ForEach(Array(vm.PostsList.keys),id: \.self){ key in
//                                    Post(profileName: key, content: key)
//                                    
//                                }
                                
                                ForEach(vm.PostsList){ posts in
                                    Post(profileName: posts.userId.description, content: posts.content, profilePicURL: posts.userId, time: "1 day ago",img:posts.imgURL ?? "")
////                                    Divider()
                                }

                            }
                            
                            
                            Spacer()
                            
                            //TabView
                            
                        }
                    }
                }.tabItem {
                    Image(systemName:"house.fill")
                    Text("Home")
                    
                }
                
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                CreatePostView()
                    .tabItem {
                        Image(systemName:"plus.circle.fill")
                            .foregroundStyle(Color.theme.richBlack)
                    }
                
                FavoriteView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorite")
                    }
                
                AccountView(name: vm.userInfo?.username ?? "Error", img: vm.userInfo?.imgUrl ?? "", user: vm.userInfo ?? User(id: "", username: "", password: "", email: "", bio: "", imgUrl: "", createdAt: "" , firstName: "", gender: "", dOb: "" ))
                    .environmentObject(vmForAccView)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                            .overlay(
                                Image("BG")
                            )
                        Text("Account")
                    }
            }.toolbarColorScheme(.dark, for: .tabBar)
                
            
            
                
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = UIColor(Color.theme.ashGray)
        }
        
        
}
    
    
    
}





struct UserView_Preview: PreviewProvider {
    
    
    static let vm = UserViewModel()
    
    static var previews: some View{
        UserView()
            .environmentObject(vm)
    }
}


extension UserView {
    var navBar: some View {
        HStack{
            Image("BG")
                .resizable()
                .scaledToFit()
                .frame(width:100,height: 100)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "ellipsis.message")
                .padding(.trailing)
            Image(systemName: "gear")
                .padding(.trailing)
                .onTapGesture {
                    vm.signOut()
                    
                }
            Image(systemName: "bell.fill")
                .padding(.trailing)
        }
    }
    
    var Filters: some View {
        HStack{
            FiltersShape()
                .padding()
            
        }
    }
    
    var Stories: some View {
        ScrollView(.horizontal){
            HStack(spacing:10 ){
                ForEach(vm.PostsList){ user in
                    Story(userId:user.userId)
                }
            }.padding()
            
        }
    }
    
    
//    var tabV: some View {
////        TabView{
////            Text("HomeTab")
////                .opacity(0)
////                .tabItem {
////                    Image(systemName: "house.fill")
////                    Text("Home")
////                }
////        }
//    }
}
