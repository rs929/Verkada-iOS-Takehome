//
//  PokemonGalleryViewModel.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import SwiftUI

class PokemonGalleryViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isLoading: Bool = false
    @Published var isShiny: Bool = false
    
    @Published var pokedexEntries: [PokedexEntry] = []
    @Published var pokemon: [Pokemon] = []

    @Published var selectedPokemon: Pokemon?
    @Published var selectedTypes: [TypeIconImage] = []

    private var offset = 0
    private let limit = 20

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Helper Functions

    func getPokedexEntries() {
        guard !isLoading else { return }

        isLoading = true

        Task {
            do {
                let pokedexResponse = try await NetworkManager.shared.getPokedexEntries(limit: limit, offset: offset)

                DispatchQueue.main.async {
                    self.pokemon.append(contentsOf: pokedexResponse)
                    self.offset += self.limit
                    self.isLoading = false
                }
            } catch {
                NetworkManager.shared.logger.error("Error in PokemonGalleryViewModel.getPokedexEntries: \(error)")
                isLoading = false
            }
        }
    }

    func loadMoreEntries() {
        if pokemon.last?.id == pokemon.count {
            getPokedexEntries()
        }
    }
}

