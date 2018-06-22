//
//  APIService.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

struct APIService {
    
    enum Result<T> {
        case success(T)
        case failure(NetworkingError)
    }
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func load<T>(_ resource: APIResource<T>, completion: ((Result<T>) -> Void)? = nil) {
        
        var urlRequest = URLRequest(url: resource.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        urlRequest.httpMethod = resource.method.rawValue
        
        if !resource.headers.isEmpty {
            urlRequest.allHTTPHeaderFields = resource.headers
        }
        
        if !resource.body.isEmpty {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: resource.body, options: [])
            } catch let jsonHttpBodyError {
                DispatchQueue.main.async { completion?(.failure(.other(jsonHttpBodyError))) }
            }
        }
        
        // Assuming that our endpoint will always use "application/json" as "Content-Type"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.dataTask(with: urlRequest) { (data, _, error) in
            
            switch error {
                
            case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                DispatchQueue.main.async { completion?(.failure(.noInternet)) }
                
            case .some(let error):
                DispatchQueue.main.async { completion?(.failure(.other(error))) }
                
            case .none:
                guard let result = data.flatMap(resource.parseData) else {
                    DispatchQueue.main.async { completion?(.failure(.parsingFailed)) }
                    return
                }
                DispatchQueue.main.async { completion?(.success(result)) }
            }
        }
        
        task.resume()
    }
}
