//
//  Conversation.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 26/01/1446 AH.
//

import Foundation

struct Conversation:Identifiable{
    
    let id:UUID
    
    let createdAt:String
    
    enum CodingKeys:String,CodingKey{
        case id = "conversation_id"
        case createdAt = "created_at"
    }
}
