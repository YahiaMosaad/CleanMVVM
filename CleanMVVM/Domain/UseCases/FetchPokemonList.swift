//
//  FetchPokemonList.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation

protocol FetchPokemonListUseCase {
    func execute(requestValue: PokemonListUseCaseRequestValue,
                 onSuccess: @escaping (PokemonResponse) -> (),
                 onFailure: @escaping (NetworkError) -> ())
    
}

final class FetchPokemonList: FetchPokemonListUseCase{
    typealias ResultValue = (onSuccess: (PokemonResponse) -> (),
                             onFailure: (NetworkError) -> ())
    
    private let pokemonQueriesRepository: PokemonQueriesRepository
    private let requestValue: PokemonListUseCaseRequestValue


    init(pokemonQueriesRepository: PokemonQueriesRepository, requestValue: PokemonListUseCaseRequestValue) {
        self.pokemonQueriesRepository = pokemonQueriesRepository
        self.requestValue = requestValue
    }
    func execute(requestValue: PokemonListUseCaseRequestValue,
                 onSuccess: @escaping (PokemonResponse) -> (),
                 onFailure: @escaping (NetworkError) -> ()){
        return pokemonQueriesRepository.FetchPokemonListFromServer(requestValue: requestValue) { response in
                onSuccess(response)
        } onFailure: { error in
            onFailure(error)
        }
    }
}
