//
//  UserModel.swift
//  apiCallerSwiftUi
//
//  Created by Aarish Khanna on 11/01/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let name: String
    let company: Company
}

struct Company: Codable {
    let name: String
}





