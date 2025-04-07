//
//  String.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 06/01/1446 AH.
//

import Foundation

extension String {
    var withZeroWidthSpaces:String{
        map({String($0)}).joined(separator: "\u{200B}")
    }
}
