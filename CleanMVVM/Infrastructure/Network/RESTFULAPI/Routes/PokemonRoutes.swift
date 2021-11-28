//
//  PokemonRoutes.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
struct FetchPokemonRoute: APIRoute {
    var path: String { "/api/v2/pokemon" }
    var method: APIClient.Method { .get }
//    var limit: Int
//    var offset: Int
    var requestModel: APICodable?
    var isLocalized: Bool { true }
    
    init(limit: Int, offset: Int) {
        self.requestModel = PokemonListUseCaseRequestValue(limit: limit, offset: offset)
    }
}
