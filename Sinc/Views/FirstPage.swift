//
//  FirstPage.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 16/01/1446 AH.
//
//

import SwiftUI

struct FirstPage: View {
    var body: some View {
        ZStack{
            Color.theme.ashGray.ignoresSafeArea()
            VStack{
                Text("Welcome to ")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.richBlack)
                    .fontDesign(.rounded)
                    
                
                Image("BG")
                
                
            }
            
            
        }
    }
}

#Preview {
    FirstPage()
}
