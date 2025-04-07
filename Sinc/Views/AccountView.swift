//
//  AccountView.swift
//  Sinc
//
//  Created by boshFbt on 19/06/2024.
//

import SwiftUI

struct AccountView: View {
    var following:Int = 217
    var followers:Int = 118
    var posts:Int = 3
    var name:String
    var img:String
    var user:User
    @EnvironmentObject var vm: AccountViewModel
    
    var body: some View {
        ZStack{
            Color.theme.ashGray.ignoresSafeArea()
            
            backgroundRect
            
            ScrollView{
                
            VStack {
                HStack{
                    Text("Profile")
                        .font(.title)
                        .bold()
                }
                
                
               ProfilePictureAcc(photo: img)
                
               nameAndButtons
               acccountName
               bio
               followAndPosts
                    .padding()
               shapes
               
                Spacer()
                
                    
                    VStack{
                            ForEach(vm.userPosts){ post in
                                
                                Post(content: post.content, time: post.createdAt, img: post.imgURL ?? "")
//                                print(post.content)
                            }
                        }
                }
                
                
            
                    
                
            }
                
                
            
        }.onAppear(perform: {
            Task{
               await vm.getPosts()
            }
        })
        .navigationTitle("Profile")
    }
}

//#Preview {
//    AccountView(name:"ShadiBou")
//}

extension AccountView {
    var backgroundRect: some View {
        VStack{
            RoundedRectangle(cornerRadius:55)
                .foregroundStyle(Color.theme.lightAshGray)
                .frame(width:(UIScreen.current?.bounds.width)!,height:.infinity)
            
        }
    }
    
    var nameAndButtons: some View {
        HStack{
            Button {
                
            } label: {
                AccountViewButton(content: "Edit Profile")
                    .padding(.leading)
            }
            Spacer()
            
                Text(name)
                    .bold()
                
            Spacer()
            
            Button {
                
            } label: {
                AccountViewButton(content: "Settings")
                    .padding(.trailing)
            }

        }
    }
    
    var acccountName: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.theme.ashGray)
                .frame(width:110,height:25)
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 1)
                .frame(width:110,height:25)
            
            Text("@" + name)
                .font(.footnote)
        }
            
    }
    
    var bio:some View {
        Text("Digital Goodies Team - Web & Mobile UI/UX development;Graphics;Illustrations")
    }
    
    var followAndPosts: some View {
        HStack(spacing:30) {
            Following

            Followers

            Posts
        }
    }
    
    var Following: some View {
        HStack{
            Text("\(following)")
                .bold()
            Text("Following")
                .font(.subheadline)
                .foregroundStyle(Color.gray)
            
        }
    }
    
    var Followers: some View {
        HStack {
            Text("\(followers)")
                .bold()
            Text("Followers")
                .font(.subheadline)
                .foregroundStyle(Color.gray)
        }
    }
    
    var Posts: some View {
        HStack {
            Text("\(posts)")
                .bold()
            Text("posts")
                .font(.subheadline)
                .foregroundStyle(Color.gray)
        }
    }
    
    var shapes: some View {
        Rectangle()
            .frame(width: .infinity, height:60)
            .foregroundStyle(Color.theme.lightAshGray)
            .overlay(
                Rectangle()
                    .stroke(lineWidth:0.6)
                    .frame(width:.infinity, height:60)
                    
            )
            .overlay(
                HStack(spacing:(UIScreen.current?.bounds.width)! * 0.4){
                    Image(systemName: "square.grid.2x2")
                    
                    Image(systemName:"bookmark")
                }
            )
    }
}
