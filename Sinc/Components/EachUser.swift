//
//  EachUser.swift
//  Sinc
//
//  Created by boshFbt on 27/06/2024.
//

import SwiftUI

struct EachUser: View {
    var img:UIImage
//    @State var realImg:UIImage = UIImage(named:"ProfileDef")!
    var name:String
    var url:String
    @State var convImg:UIImage = UIImage(named:"ProfileDef")!
    var body: some View {
        HStack(spacing:14){
            ProfilePic(img: convImg)
            Text(name)
            Spacer()
                
        }.padding(.top)
            .task {
                do{
                    convImg = try await ImageManager.instance.fetchData(url: url) ?? UIImage(named:"ProfileDef")!
                }catch{
                    print(error)
                }
                
            }
    }
}

//#Preview {
//    EachUser(img: UIImage(named: "ProfileDef")!,
//             name: "Dervis")
//}
