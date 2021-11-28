//
//  PokemonListViewModel.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
protocol PaginationRules {
//    func getPaginationLimitAndOffset() -> PokemonListUseCaseRequestValue
    func getPaginationLimitAndOffset(itemsLimit: Int, pageNumber: Int) -> PokemonListUseCaseRequestValue
}

final class PokemonListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var pokemonsList = [Pokemon]()

    private let fetchPokemonListUseCase: FetchPokemonListUseCase

    
    var paginationRules: PaginationRules
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var limit = 20
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    init(paginationRules: PaginationRules, fetchPokemonListUseCase: FetchPokemonListUseCase) {
        self.paginationRules = paginationRules
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
    }
    
    func didLoad() {
        self.pokemonsList.removeAll()
        self.isLoading = true
        getPokemonListData()
       
    }
    func refreshData() {
        self.didLoad()
    }
    func loadMore() {
        self.appendPage()
    }
    // MARK: - Private
    private func getPokemonListData() {
        isLoading = true
        let requestQuery = paginationRules.getPaginationLimitAndOffset(itemsLimit: limit, pageNumber: nextPage)
        fetchPokemonListUseCase.execute(requestValue: requestQuery, onSuccess: fetchPokemonssSuccessfulHandler, onFailure: fetchPokemonssErrorHandler)
    }
    
    private func fetchPokemonssSuccessfulHandler(_ pokemons: PokemonResponse) {

        DispatchQueue.main.async {
            self.isLoading = false
            self.updatePokemonList(pokemonArray: pokemons.results)
        }
    }
        
    private func fetchPokemonssErrorHandler(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
        #if DEBUG
        print(error)
        #endif
    }
    
    private func updatePokemonList(pokemonArray: [Pokemon]) {
        self.pokemonsList += pokemonArray
        print("count of pokemons: \(pokemonsList.count)")

    }

    private func appendPage() {
        currentPage += 1
        totalPageCount += 1

        self.getPokemonListData()
    }
}
 
