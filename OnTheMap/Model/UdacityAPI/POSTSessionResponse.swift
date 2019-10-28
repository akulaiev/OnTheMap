//
//  POSTSessionResponse.swift
//  OnTheMap
//
//  Created by Anna KULAIEVA on 10/24/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

struct LocationPostResponse: Codable {
    let createdAt: String
    let objectId: String
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}

struct POSTSessionResponse: Codable {
    let account: Account
    let session: Session
}
