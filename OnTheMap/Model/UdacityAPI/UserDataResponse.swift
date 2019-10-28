
//
//  UserDataResponse.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 28.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

struct UserDataResponse: Codable {
    
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
