//
//  APIClient+Pokemons.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
extension APIClient {
    struct Pokemons {
        
        static func fetchPokemonsWithPagination(limit: Int, offset: Int, onSuccess: @escaping (PokemonResponse) -> (),onFailure: @escaping (NetworkError) -> ()){
            APINetwork.perform(route: FetchPokemonRoute(limit: limit, offset: offset),
                               responseModelType: PokemonResponse.self)
            { (result) in
                if case .success(let response) = result, let pokResponse = response as?  PokemonResponse {
                    onSuccess(pokResponse)
                } else {
                    onFailure(.dataExtract(TextKeys.Errors.defaultMessage))
                }
            }
        }
    }
}
