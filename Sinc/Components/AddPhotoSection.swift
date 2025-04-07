//
//  AddPhotoSection.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 04/01/1446 AH.
//

import SwiftUI

struct AddPhotoSection: View {
    @Binding var img:Image?
    var body: some View {
        ZStack {
                RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.ashGray)
                .frame(width:280,height:230)
                    
            if let image = img {
                thereIsImage
                    
                        
            }else {
                thereIsNoImage

                
            }
        }
        
    }
}

//#Preview {
//    AddPhotoSection(img:$Image("PostPic"))
//}


extension AddPhotoSection{
    var thereIsNoImage: some View{
        RoundedRectangle(cornerRadius: 10)
            .frame(width:260,height:210)
            .opacity(0.5)
            .overlay(
                Image(systemName: "camera.fill")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.lightAshGray)
            )
    }
    
    var thereIsImage: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .frame(width:260,height:210)
            .overlay(
                Image("PostPic")
                    .resizable()
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.theme.lightAshGray)
                            
                        ,alignment: .bottomTrailing
                    )
            )
            
            
    }
}
