//
//  User.swift
//  Sinc
//
//  Created by boshFbt on 25/04/2024.
//

import Foundation
import Supabase

struct User: Codable,Sendable,Identifiable {
    let id:String
    let username:String
    let password:String
    let email:String
    let bio:String?
    let imgUrl:String?
    let createdAt:String?
    let firstName:String
    let gender:String
    let dOb:String
    
    enum CodingKeys: String,CodingKey {
        case id = "user_id"
        case username,email,bio,gender
        case password = "pwd"
        case imgUrl = "img_url"
        case createdAt = "created_at"
        case firstName = "firstname"
        case dOb = "dob"
    }
}
