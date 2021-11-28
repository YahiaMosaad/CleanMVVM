//
//  PokemonQueriesRepository.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 23/11/2021.
//

import Foundation

final class PokemonQueriesRepository {
    
}

extension PokemonQueriesRepository: PokemonListRepository {
    
    func FetchPokemonListFromServer(requestValue: PokemonListUseCaseRequestValue, onSuccess: @escaping (PokemonResponse) -> (), onFailure: @escaping (NetworkError) -> ()) {
        APIClient.Pokemons.fetchPokemonsWithPagination(limit: requestValue.limit, offset: requestValue.offset) { response in
            onSuccess(response)
        } onFailure: { error in
            onFailure(error)
        }
    }
    
    
}
