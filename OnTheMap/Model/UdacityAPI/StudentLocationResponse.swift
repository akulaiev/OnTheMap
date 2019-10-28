//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Anna Koulaeva on 25.10.2019.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

struct StudentLocationResponse: Codable {
    let results: [StudentInformation]
}
