//
//  Entity.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation

struct UserData: Codable {
    let data: [User]
}


struct User: Codable {
    let email: String?
    let avatar: String?
    let first_name: String?
}
