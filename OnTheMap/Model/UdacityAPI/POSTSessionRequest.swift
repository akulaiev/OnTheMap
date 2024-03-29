//
//  POSTSessionRequest.swift
//  OnTheMap
//
//  Created by Anna Kulaieva on 10/24/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

struct POSTSessionRequest: Codable {
    let udacity: Dictionary<String, String>
    
    init(username: String, password: String) {
        self.udacity = ["username": username, "password": password]
    }
}
