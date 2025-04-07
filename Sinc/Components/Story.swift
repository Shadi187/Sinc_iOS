//
//  Stories.swift
//  Sinc
//
//  Created by boshFbt on 18/06/2024.
//

import SwiftUI

struct Story: View {
    var ownStory:Bool = false
    @State var userName:String = ""
    var userId:String
    var body: some View {
        VStack {
            
            ZStack{
                // Photo
                Image("StoryPic")
                    .resizable()
                    .scaledToFill()
                    .frame(width:85,height:150)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                //cover
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray)
                    .opacity(0.76)
                    .frame(width:85,height:150)
                
                VStack{
                    Image(systemName:ownStory ? "plus" : "eye.fill")
                        .foregroundStyle(Color.white)
                }.frame(width:85,height:150)
                
            }
            //Name
            Text(ownStory ? "Your Story" : userName)
        }
        .onAppear{
            Task{
                userName = try await SupabaseManager.instance.getUserName(userId: userId)
            }
        }
        
    }
}

//#Preview {
//    Story()
//}
