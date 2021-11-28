//
//  PaginationRulesManager.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import Foundation
// Create this class to make it easy when test ViewModel by creating dumy class conform protocol then passing data
final class PaginationRulesManager: PaginationRules {
    func getPaginationLimitAndOffset(itemsLimit: Int, pageNumber: Int) -> PokemonListUseCaseRequestValue {
        return PokemonListUseCaseRequestValue(limit: itemsLimit, offset: pageNumber)
    }
    
}
