//
//  Data+API.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
extension Data {
    var stringRepresentation: String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
    
    var apnTokenRepresentation: String {
        return self.reduce("", {$0 + String(format: "%02X", $1)})
    }
    
    func decode<T: Decodable>(decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase)
        throws -> T
    {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decodingStrategy
        
        return try decoder.decode(T.self, from: self)
    }
}

