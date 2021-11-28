//
//  PokemonListRepository.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import Foundation

protocol PokemonListRepository {
    typealias ResultValue = (onSuccess: (PokemonResponse) -> (),
                             onFailure: (NetworkError) -> ())

    func FetchPokemonListFromServer(requestValue: PokemonListUseCaseRequestValue, onSuccess: @escaping (PokemonResponse) -> (),onFailure: @escaping (NetworkError) -> ())
}
