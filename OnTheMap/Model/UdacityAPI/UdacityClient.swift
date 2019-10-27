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
    
    enum Endpoints {
        static let baseString = "https://onthemap-api.udacity.com/v1"
        
        case session
        case location
        
        var stringValue: String {
            switch self {
                case .session: return Endpoints.baseString + "/session"
                case .location: return Endpoints.baseString + "/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getSessionID(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body =  POSTSessionRequest(username: username, password: password)
        NetworkingTasks.taskForRequest(requestMethod: "POST", udacityApi: true, url: Endpoints.session.url, responseType: POSTSessionResponse.self, body: body) { (response, error) in
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
        var request = URLRequest(url: Endpoints.session.url)
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
    
    class func getStudentsLocations(completion: @escaping (StudentLocationResponse?, Error?) -> Void)  {
        let url = URL(string: Endpoints.location.stringValue + "?limit=100")!
        let emptyBody: String? = nil
        NetworkingTasks.taskForRequest(requestMethod: "GET", udacityApi: false, url: url, responseType: StudentLocationResponse.self, body: emptyBody) { (response, error) in
            if let response = response {
                completion(response, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }
}
