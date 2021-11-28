//
//  APIErrors.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
struct TextError: Error {
    var text: String?
}

enum APIError: String, Error {
    case unauthorized
    case wrongBaseURL
    case wrongResponse
    case generalError
}

