//
//  CaptionTextFieldView.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 04/01/1446 AH.
//

import Foundation
import SwiftUI

struct CaptionTextFieldModifier: ViewModifier {
    @Binding var condition:Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    
                    .fill(Color.white)
                    
                    .stroke(condition ? .red : .clear)
                    .frame(width:360,height:160)
            )
            .padding(.leading)
            .padding(.trailing
            )
            .foregroundStyle(Color.black)

    }
}
