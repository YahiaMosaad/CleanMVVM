//
//  PokemonData.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation

struct PokemonResponse: APICodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    
}
struct ResultsResponse: APICodable {
    let results: [Pokemon]
    #if DEBUG
    static let mock = [
        Pokemon(id: 1, name: "bikatcho"), Pokemon(id: 2, name: "bulbasur")
    ]
    #endif
}
struct Pokemon: APICodable, Identifiable, Equatable {
    private static var totalFound = 0

    let id: Int
    let name: String
    var  url: URL {
        URL(string: "\(URLConstants.largeImageBaseURL)\(name).jpg")!
    }

    private enum PokemonKeys: String, CodingKey {
        case name
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        Pokemon.totalFound += 1
        self.id = Pokemon.totalFound
    }
}

extension Pokemon {
    static let mock = Self.init(id: 1, name: "bikatcho")
}


