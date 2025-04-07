//
//  AddedSuccessfully.swift
//  Sinc
//
//  Created by boshFbt on 20/06/2024.
//

import SwiftUI

struct AddedSuccessfully: View {
    var content:String = "Account Created"
    var body: some View {
        ZStack{
            Group{
            RoundedRectangle(cornerRadius: 12)
                .frame(width:190,height:180)
                .foregroundStyle(Color.white)
            VStack{
                ZStack{
                    Image(systemName:"checkmark")
                        .font(.largeTitle)
                        .foregroundStyle(Color.black)
                        
                    
                    Circle()
                        .stroke(lineWidth:2.0)
                        .frame(width: 100, height:100)
                        .foregroundStyle(Color.black)
                        
                }
                
                Text(content)
                    .foregroundStyle(Color.black)
            }
            .foregroundStyle(Color.white)
            .bold()
            
        }
        }
    }
}

#Preview {
    AddedSuccessfully()
}
