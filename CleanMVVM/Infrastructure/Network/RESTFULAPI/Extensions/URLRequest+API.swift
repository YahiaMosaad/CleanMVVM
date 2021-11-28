//
//  URLRequest+API.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
extension URLRequest {
    var httpBodyStringRepresentation: String? {
        return self.httpBody?.stringRepresentation
    }
}
