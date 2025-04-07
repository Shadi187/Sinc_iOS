//
//  Post.swift
//  Sinc
//
//  Created by boshFbt on 19/06/2024.
//

import SwiftUI

struct Post: View {
    var profileName:String = "2hijk"
    var content:String
    @State var profilePic:UIImage = UIImage(named: "ProfileDef")!
    @State var profilePicURL:String = ""
    var time:String
    @State var isPressed:Bool = false
    @State var username:String = ""
    @State var img:String
    @State var realImg:UIImage = UIImage(named: "ProfileDef")!
    var body: some View {
//        VStack{
//            ZStack{
//                Rectangle()
//                    .fill(Color.theme.ashGray)
//                    .frame(width:370,height:290)
//                    .padding(.trailing)
//                    .padding(.leading)
//                VStack{
//                    HStack(alignment:.top) {
//                        
//                        ProfilePic()
//                            .padding(.init(top: 10, leading: 25, bottom: 0, trailing: 0))
//                        
//                        Text(profileName)
//                            .foregroundStyle(Color.theme.richBlack)
//                            .font(.callout)
//                            .bold()
//                            .padding(.init(top: 20, leading:0,bottom:0,trailing: 0))
//                            
//                        Spacer()
//                        
//                        Image(systemName: "ellipsis")
//                            .foregroundStyle(Color.white)
//                            .bold()
//                            .padding(.trailing)
//                            .padding(.trailing)
//                            .padding(.top)
//                            .padding(.init(top: 10, leading:0,bottom:0,trailing: 0))
//                            
//                    }.padding(.init(top: 15, leading: 0, bottom: 0, trailing: 0))
//                    
//                    Spacer()
//                    
//                    Image(uiImage: img)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width:370,height:210)
//                        .clipShape(Rectangle())
//                        .padding(.trailing)
//                        .padding(.leading)
//                }
//                
//            }
//            .frame(width:360,height:250)
//            .padding()
//            .background(
//                Rectangle()
//                    .stroke(lineWidth:1)
//                    .frame(width:370,height:290)
//            
//            )
//            //: ZStack
//            
//            Text(content)
//                .font(.title2)
//                .padding()
//            HStack{
//                HStack{
//                    Image(systemName: "heart.fill")
//                        .font(.footnote)
//                        .foregroundStyle(isPressed ? Color.red : Color.black)
//                        .onTapGesture {
//                            withAnimation(.spring){
//                                isPressed.toggle()
//                            }
//                        }
//                    Text("2.7k likes")
//                        .foregroundStyle(Color.gray)
//                        .font(.footnote)
//                }
//                Spacer()
//                HStack{
//                    Text("14k views")
//                        .foregroundStyle(Color.gray)
//                        .font(.footnote)
//                }
//                Spacer()
//                HStack{
//                    Text("1.1k comments")
//                        .foregroundStyle(Color.gray)
//                        .font(.footnote)
//                }
//                Spacer()
//                HStack{
//                    Text("3 Days ago")
//                        .foregroundStyle(Color.gray)
//                        .font(.footnote)
//                        
//                }
//                
//            }.padding(.trailing)
//                .padding(.leading)
//        }
        
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.lightAshGray)
                .frame(width:333,height: 400)
                .overlay(
                    VStack {
                        upperPart
                        Divider()
                        
                        Text(content)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.leading)
                            .frame(alignment:.leading)
                            
                        Image(uiImage: realImg)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:333,height:210)
                                    .clipShape(Rectangle())
                                    .padding(.trailing)
                                    .padding(.leading)
                                    .task {
                                        do{
                                        realImg = try await ImageManager.instance.fetchData(url: img) ?? UIImage(named:"ProfileDef")!
                                        }catch{
                                            print(error)
                                        }
                                    }
                     lowerPart
                    }
                    ,alignment: .top
                )
            
        
        
    }
}


//#Preview {
//    Post(profileName: "DDASDSA", content: "fdasfasfasfasfdasfasfdasfsadfdasffadsfasfasfafadsfdasfasfasdfasfadsfasdfdasffasdfasfdasfasfadsfaDSADAS", time: "1 day ago", img: UIImage(named:"PostPic")!)
//}

extension Post {
    var upperPart: some View {
        HStack(){
            ProfilePic(img: profilePic)
                .padding(.leading)
                .padding(.top)
            Text(username)
                .bold()
                .task {
                    do { 
                        username = try await SupabaseManager.instance.getUserName(userId: profileName)
                        profilePic = try await ImageManager.instance.fetchData(url: SupabaseManager.instance.getUserImg(userId: profilePicURL)) ?? UIImage(named:"ProfileDef")!
                    }
                    catch{
                        print(error)
                    }
                }
                
            Spacer()
            VStack(spacing:10) {
                Image(systemName: "ellipsis")
                    .padding(.trailing)
                Text(time)
                    .font(.caption)
                    .padding(.trailing)
                    
            }.foregroundStyle(Color.gray)

            
            
        }
    }
    
    var lowerPart: some View {
        HStack{
            Image(systemName:"message")
                .padding(.leading)
            
            Text("Comment")
            Spacer()
            
            Image(systemName:"hand.thumbsup")
                .padding(.trailing)
        }.foregroundStyle(Color.gray)
    }
}

/*
 
  
 */
