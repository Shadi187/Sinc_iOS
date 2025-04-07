//
//  FiltersShape.swift
//  Sinc
//
//  Created by boshFbt on 18/06/2024.
//

import SwiftUI

struct FiltersShape: View {
    @State var is1stPressed:Bool = true
    @State var is2ndPressed:Bool = false 
    @State var is3rdPressed:Bool = false
    @State var is4thPressed:Bool = false 
    
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(is1stPressed ? Color.clear : Color.theme.richBlack)
                .frame(width:90,height:40)
            
                .overlay{
                    Text("New Posts")
                        .foregroundStyle(is1stPressed ? Color.theme.richBlack : Color.white)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.theme.richBlack)
                                .frame(width:90,height:40)
                        )
                }
            
                .onTapGesture {
                    withAnimation(.spring) {
                        is1stPressed = true
                        is2ndPressed = false
                        is3rdPressed = false
                        is4thPressed = false
                    }
                    
                }
            
            RoundedRectangle(cornerRadius: 15)
                .fill(is2ndPressed ? Color.clear : Color.theme.richBlack)
                .frame(width:80,height:40)
            
                .overlay{
                    Text("Trending")
                        .foregroundStyle(is2ndPressed ? Color.theme.richBlack : Color.white)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.theme.richBlack)
                                .frame(width:80,height:40)
                        )
                }
            
                .onTapGesture {
                    withAnimation(.spring) {
                        is1stPressed = false
                        is2ndPressed = true
                        is3rdPressed = false
                        is4thPressed = false
                    }
                    
                }
            
            RoundedRectangle(cornerRadius: 15)
                .fill(is3rdPressed ? Color.clear : Color.theme.richBlack)
                .frame(width:80,height:40)
            
                .overlay{
                    Text("For You")
                        .foregroundStyle(is3rdPressed ? Color.theme.richBlack : Color.white)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.theme.richBlack)
                                .frame(width:80,height:40)
                        )
                }
            
                .onTapGesture {
                    withAnimation(.spring) {
                        is1stPressed = false
                        is2ndPressed = false
                        is3rdPressed = true
                        is4thPressed = false                    }
                    
                }
            
            
            RoundedRectangle(cornerRadius: 15)
                .fill(is4thPressed ? Color.clear : Color.theme.richBlack)
                .frame(width:80,height:40)
            
                .overlay{
                    Text("All")
                        .foregroundStyle(is4thPressed ? Color.theme.richBlack : Color.white)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.theme.richBlack)
                                .frame(width:80,height:40)
                        )
                }
            
                .onTapGesture {
                    withAnimation(.spring) {
                        is1stPressed = false
                        is2ndPressed = false
                        is3rdPressed = false
                        is4thPressed = true
                        
                    }
                }
        }
    }
    
    //#Preview {
    ////    FiltersShape(pressed:false)
    //}
}
