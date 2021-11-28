//
//  URLResponse+Extensions.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
extension URLResponse {
    enum Status  {
        case ok
        case undefined
        case unautorized
        
        init(withURLResponse response: URLResponse) {
            switch response.code {
                case .none:
                    self = .undefined
                case .some(401):
                    self = .unautorized
                default:
                    self = .ok
            }
        }
    }
    
    var code: Int? { (self as? HTTPURLResponse)?.statusCode }
    var status: Status { Status(withURLResponse: self) }
}
