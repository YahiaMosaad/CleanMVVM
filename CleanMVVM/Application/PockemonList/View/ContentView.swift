//
//  ContentView.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonListViewModel(paginationRules: PaginationRulesManager(), fetchPokemonListUseCase: FetchPokemonList(pokemonQueriesRepository: PokemonQueriesRepository(), requestValue: PokemonListUseCaseRequestValue(limit: 10, offset: 1)))

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if viewModel.isLoading {
                        LoadingIndicator
                    }
                    else {
                        if viewModel.pokemonsList.count > 0 {
                            ForEach(viewModel.pokemonsList) { pokemon in
                                PokemonRow(pokemon: pokemon)
                                    .onAppear {
                                        if pokemon == viewModel.pokemonsList.last {
                                            viewModel.loadMore()
                                        }
                                    }
                            }
                        } else{
                            EmptyView()
                        }
                    }
                }
                .refreshable {
                    print("Do your refresh work here")
                    viewModel.refreshData()
                }
                .navigationTitle("Pokemon List")
            }
        }
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().showsVerticalScrollIndicator = false
            viewModel.didLoad()
        }
    }
    
    private var LoadingIndicator: some View {
        LoaderView(tintColor: .gray, scaleSize: 1.0).padding(.bottom,50).hidden(viewModel.isLoading)

    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
