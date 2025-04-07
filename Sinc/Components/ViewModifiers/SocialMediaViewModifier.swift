//
//  SocialMediaViewModifier.swift
//  Sinc
//
//  Created by boshFbt on 24/06/2024.
//

import Foundation
import SwiftUI

struct SocialMediaViewModifier:ViewModifier {
    func body(content: Content) -> some View {
        content
//            .resizable()
            .scaledToFit()
            .padding()
            .frame(width:100,height:60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    
            )
    }
}
