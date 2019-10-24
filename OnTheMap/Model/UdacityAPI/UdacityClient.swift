//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Anna KULAIEVA on 10/24/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

class UdacityClient: NetworkingTasks {
    
    struct AuthenticationInfo {
        static var apiKey: Int = 0
        static var sessionId: String = ""
    }
    
    static let baseString = "https://onthemap-api.udacity.com/v1/"
    static var baseUrl: URL {
        return URL(string: baseString)!
    }
    
    class func getSessionID(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body =  POSTSessionRequest(username: username, password: password)
        taskForPostRequest(addAcceptVal: true, url: baseUrl, responseType: POSTSessionResponse.self, body: body) { (response, error) in
            guard let response = response else {
                print(error!.localizedDescription)
                completion(false, error)
                return
            }
            self.AuthenticationInfo.sessionId = response.session.id
            self.AuthenticationInfo.apiKey = response.account.key
            completion(true, nil)
        }
    }
}
