//
//  PokemonGalleryItemView.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import SwiftUI

struct PokemonGalleryItemView: View {

    // MARK: - Properties

    let isShiny: Bool
    let pokemon: Pokemon

    // MARK: - UI

    var body: some View {
        VStack(alignment: .center) {
            CachingImageView(url: isShiny ? pokemon.sprites.frontShiny : pokemon.sprites.frontDefault)

            Text(pokemon.name.capitalized)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
        .padding(8)
        .background(.white.opacity(0.8))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

