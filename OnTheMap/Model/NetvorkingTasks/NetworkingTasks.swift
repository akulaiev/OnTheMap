//
//  NetworkingTasks.swift
//  OnTheMap
//
//  Created by Anna KULAIEVA on 10/24/19.
//  Copyright © 2019 Anna Kulaieva. All rights reserved.
//

import Foundation

class NetworkingTasks {
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Decodable>(addAcceptVal: Bool, url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        if addAcceptVal {
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//        }
        let body = body
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                print(response!)
                let decoder = JSONDecoder()
                var newData: Data
                if addAcceptVal {
                    newData = data
                }
                else {
                    let range = 5..<data.count
                    newData = data.subdata(in: range)
                }
                let response = try decoder.decode(ResponseType.self, from: newData)
                print(response)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
