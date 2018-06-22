//
//  NetworkingError.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

public enum NetworkingError: LocalizedError {
    case noInternet
    case parsingFailed
    case other(Error)
    
    public var errorDescription: String? {
        switch self {
        case .noInternet: return "[Networking] Not connected to internet"
        case .parsingFailed: return "[Networking] Parsing failed"
        case .other(let error): return "[Networking] \(error.localizedDescription)"
        }
    }
}

extension NetworkingError: Equatable {
    public static func ==(lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}
