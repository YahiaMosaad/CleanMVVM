//
//  PokemonRow.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(alignment: .top){
            ZStack{
                Circle()
                    .fill(.purple)
                    .frame(width: 65.0, height: 65.0)

                WebImage(url: pokemon.url)
                    .placeholder(Image(systemName: "person"))
                    .resizable()
                    .renderingMode(.original).resizable()
                    .frame(width: 65.0, height: 65.0, alignment: .center)
                                    .background(.white)
                    .clipShape(Circle())
            }
            PokemonDescriptionView(pokemon: pokemon)
                .padding(.leading, 20)
            Spacer()

        }
        .padding(.horizontal, 20.0)
    }
}

#if DEBUG
struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemon: Pokemon.mock)
    }
}
#endif


