//
//  TextFieldViewModifier.swift
//  Sinc
//
//  Created by boshFbt on 24/06/2024.
//

import Foundation
import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    @Binding var condition:Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    
                    .fill(Color.white)

                    .stroke(condition ? .red : .clear)
            )
            .padding(.leading)
            .padding(.trailing
            )
            .foregroundStyle(Color.black)

    }
}
