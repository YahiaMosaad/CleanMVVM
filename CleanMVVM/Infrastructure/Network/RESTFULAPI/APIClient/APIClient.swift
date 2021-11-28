//
//  APIClient.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
struct APINoContent: Codable {
}

struct APIClient {
    enum Method: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    enum Result {
        case success(_ result: Any)
        case failure(_ error: Error)
    }
}
