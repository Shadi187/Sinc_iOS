//
//  ProfilePictureAcc.swift
//  Sinc
//
//  Created by boshFbt on 23/06/2024.
//

import SwiftUI

struct ProfilePictureAcc: View {
    var photo:String
    @State var realImg:UIImage = UIImage(named:"ProfileDef")!
    var body: some View {
        ZStack{
           Circle()
            .frame(width:140,height:140)
            .foregroundStyle(Color.white)
            
            Image(uiImage:realImg)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width:120,height:120)
                .task{
                    realImg = await ImageManager.instance.fetchData(url: photo) ?? UIImage(named:"ProfileDef")!
                }
                
        }
    }
}

//struct ProfilePicAcc_Preview: PreviewProvider {
//    
//    
////    static let vm = LoginViewModel()
//    
//    static var previews: some View{
//        ProfilePictureAcc(photo: Image("ProfileDef"))
////            .environmentObject(vm)
//    }
//}
