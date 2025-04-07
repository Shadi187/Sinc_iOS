//
//  AccountViewButton.swift
//  Sinc
//
//  Created by boshFbt on 24/06/2024.
//

import SwiftUI

struct AccountViewButton: View {
    var content:String
    var body: some View {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.theme.richBlack)
                .overlay(
                    Text(content)
                        .foregroundStyle(Color.white)
                        .bold()
                )
                .frame(width:110,height:26)
    }
}

#Preview {
    AccountViewButton(content: "EditProfile")
}
