//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 25.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

//struct Results: Codable {
//    let objectId: String
//    let uniqueKey: String
//    let firstName: String
//    let lastName: String
//    let mapString: String
//    let mediaURL: String
//    let latitude: Float
//    let longitude: Float
//}

struct StudentLocationResponse: Codable {
    let results: [StudentInformation]
}
