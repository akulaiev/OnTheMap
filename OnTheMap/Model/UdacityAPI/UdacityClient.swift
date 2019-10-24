//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Anna KULAIEVA on 10/24/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct AuthenticationInfo {
        static var apiKey: String = ""
        static var sessionId: String = ""
    }
    
    static let baseString = "https://onthemap-api.udacity.com/v1/session"
    static var baseUrl: URL {
        return URL(string: baseString)!
    }
    
    class func getSessionID(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body =  POSTSessionRequest(username: username, password: password)
        NetworkingTasks.taskForPostRequest(udacityApi: true, url: baseUrl, responseType: POSTSessionResponse.self, body: body) { (response, error) in
            guard let response = response else {
                completion(false, error)
                return
            }
            self.AuthenticationInfo.sessionId = response.session.id
            self.AuthenticationInfo.apiKey = response.account.key
            completion(true, nil)
        }
    }
    
    class func logout(completion: @escaping () -> Void) {
        var request = URLRequest(url: UdacityClient.baseUrl)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            UdacityClient.AuthenticationInfo.apiKey = ""
            UdacityClient.AuthenticationInfo.sessionId = ""
            DispatchQueue.main.async {
                completion()
            }
        }
        task.resume()
    }
}
