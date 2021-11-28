//
//  APIConfiguration.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
struct APIConfiguration {
    static let `default` = APIConfiguration()
      
    var baseURL: URL? {
        var stringUrl = ""
        stringUrl = "https://pokeapi.co"

        return URL(string: stringUrl)
    }
}
