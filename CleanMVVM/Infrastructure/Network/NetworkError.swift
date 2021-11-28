//
//  NetworkErro.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
enum NetworkError: Error {
    case dataExtract(String)
    case usual(Error)
    
    var localizedDescription: String {
        switch self {
        case .dataExtract(let message):
            return message
        case .usual(let error):
            return error.localizedDescription
        }
    }
}
