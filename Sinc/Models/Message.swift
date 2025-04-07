//
//  Message.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 20/01/1446 AH.
//

import Foundation

struct Message:Identifiable{
    let id:UUID
    let conversationId:String
    let senderId:String
    let content:String
    let sentAt:String
    
    enum CodingKeys:String,CodingKey {
        case id = "message_id"
        case conversationId = "conversation_id"
        case senderId = "sender_id"
        case content
        case sentAt = "sent_at"
    }
    
    
}


/*
 message_id uuid not null default uuid_generate_v4 (),
     conversation_id uuid not null,
     sender_id uuid not null,
     content text not null,
     sent_at timestamp without time zone null default current_timestamp,
 
 */
