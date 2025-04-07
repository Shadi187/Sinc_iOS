//
//  EyeFillViewModifier.swift
//  Sinc
//
//  Created by boshFbt on 24/06/2024.
//

import Foundation
import SwiftUI

struct EyeFillViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.trailing)
            .foregroundStyle(Color.gray)
    }
}
