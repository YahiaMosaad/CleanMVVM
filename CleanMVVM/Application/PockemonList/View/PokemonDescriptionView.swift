//
//  PokemonDescriptionView.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 06/11/2021.
//

import SwiftUI

struct PokemonDescriptionView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 18))
                .padding(.bottom, 10)
            
            Text("#\(pokemon.id)")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

#if DEBUG
struct PokemonDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescriptionView(pokemon: Pokemon.mock)
    }
}
#endif
