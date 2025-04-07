//
//  ButtonViewModifier.swift
//  Sinc
//
//  Created by boshFbt on 24/06/2024.
//

import Foundation
import SwiftUI

struct ButtonViewModifier: ViewModifier {
    var text:String
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width:390,height:100)
            .foregroundStyle(Color.theme.richBlack)
            .overlay(
                Text(text)
                    .foregroundStyle(Color.white)
                    .bold()
            )
    }
}
