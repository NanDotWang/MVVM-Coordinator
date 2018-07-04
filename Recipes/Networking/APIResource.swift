//
//  APIResource.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

struct APIResource<T> {
    let url: URL
    let method: HTTPMethod
    let body: [String: Any]
    let headers: [String: String]
    let parseData: (Data) -> T?
    
    init(url: URL,
         method: HTTPMethod = .get,
         body: [String: Any] = [:],
         headers: [String: String] = [:],
         parseData: @escaping (Data) -> T?) {
        
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
        self.parseData = parseData
    }
}

/// APIResource with `Decodable` model
extension APIResource where T: Decodable {

    init(url: URL,
         method: HTTPMethod = .get,
         body: [String: Any] = [:],
         headers: [String: String] = [:]) {

        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
        self.parseData = { data in
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let decodingError {
                print("⚠️ Decoding error in \(#function): \(decodingError)")
                return nil
            }
        }
    }
}
