//
//  APICodable.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
protocol APICodable: Codable {
}

extension APICodable {
    var encodingStrategy: JSONEncoder.KeyEncodingStrategy? { return .convertToSnakeCase }

    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encodingStrategy.map {
            encoder.keyEncodingStrategy = $0
        }
        
        return encoder
    }
    
    var jsonData: Data? {
        return try? self.jsonEncoder.encode(self)
    }
}
