//
//  Post.swift
//  Sinc
//
//  Created by boshFbt on 25/06/2024.
//

import Foundation

struct Posts:Identifiable,Codable,Sendable {
    let id: UUID
    var userId:String
    let content:String
    let imgURL:String?
    let createdAt:String
    let updatedAt:String
    

    
    enum CodingKeys: String,CodingKey {
        case id = "post_id"
        case userId = "user_id"
        case imgURL = "img_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case content
    }
    
    func getUserName(userId:String) async throws -> String {
        do{
            return try await SupabaseManager.instance.getUserName(userId: userId)
        
        }catch{
            print(error)
            return "Error"
        }
    }
    
    
}

//struct showedPost:Sendable,Identifiable{
//    
//}
