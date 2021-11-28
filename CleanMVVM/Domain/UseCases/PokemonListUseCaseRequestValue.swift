//
//  PokemonListUseCaseRequestValue.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import Foundation

struct PokemonListUseCaseRequestValue: APICodable {
    let limit: Int
    let offset: Int
}


#if DEBUG
extension PokemonListUseCaseRequestValue {
    static let mocked = PokemonListUseCaseRequestValue(limit: 20, offset: 1)
}
#endif
