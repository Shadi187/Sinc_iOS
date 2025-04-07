//
//  Sequence.swift
//  Sinc
//
//  Created by boshFbt on 26/06/2024.
//

import Foundation

extension Sequence {
    func forEach(
        _ operation: (Element) async -> Void
    ) async {
        for element in self {
            await operation(element)
        }
    }
    
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self{
            try await operation(element)
        }
    }
}
