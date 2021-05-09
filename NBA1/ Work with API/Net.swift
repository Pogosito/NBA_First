//
//  Net.swift
//  NBA1
//
//  Created by Погос  on 02.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit

import Foundation

class Net {
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    static public var shared = Net()
}

var i = 0

extension Net {
    
    private func getALinkToDescriptionGame(_ date: String)-> NSMutableURLRequest {
        
        let headers = [
            "x-rapidapi-host": "api-nba-v1.p.rapidapi.com",
            "x-rapidapi-key": "94444265famshd5b3f15f26f34a8p1cabbbjsnd2699038f158"
        ]
        var request = NSMutableURLRequest()
        var currentDate = String()
        let formatter = DateFormatter()
        var urlString = String()
        formatter.dateFormat = "yyyy-MM-dd"
        if (i == 0) {
            i = i + 1
            let date = Date()
            currentDate = formatter.string(from: date)
            urlString = "https://api-nba-v1.p.rapidapi.com/games/date/\(currentDate)"
            request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            print("##################################################")
            print(request)
            print("##################################################")
        } else {
            urlString = "https://api-nba-v1.p.rapidapi.com/games/date/\(date)"
            request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            print("-------------------------------------------------------")
            print(request)
            print("-------------------------------------------------------")
        }
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
       
    public func getDescriptionGame(date: String, completion: ((Result<NBA>) -> Void)? ) {
        mainSession(request: getALinkToDescriptionGame(date) as URLRequest, completion: completion)
    }
       
    private func mainSession<T: Codable> (request: URLRequest, completion: ((Result<T>) -> Void)?) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (data, responce, error) in
            guard let jsonData = data, error == nil else { completion?(.failure(error!)); return }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                completion?(.success(decodedData))
            } catch {
                completion?(.failure(error))
            }
        }.resume()
    }
}
