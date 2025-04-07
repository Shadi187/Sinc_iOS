//
//  ProfilePic.swift
//  Sinc
//
//  Created by boshFbt on 19/06/2024.
//

import SwiftUI

struct ProfilePic: View {
    var img:UIImage
    @State var realImg:UIImage = UIImage(named:"ProfileDef")!
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 3.4)
                .foregroundStyle(Color.white)
                .frame(width:50,height:50)
            Image(uiImage:img)
                .resizable()
                .scaledToFill()
                .frame(width:50,height:50)
                .clipShape(Circle())
                
        }
    }
}

//#Preview {
//    ProfilePic()
//}
