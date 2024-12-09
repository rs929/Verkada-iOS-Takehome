//
//  PokemonGalleryView.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import SwiftUI

struct PokemonGalleryView: View {

    // MARK: - Properties

    @StateObject private var viewModel = PokemonGalleryViewModel()

    // MARK: - UI

    var body: some View {
        GeometryReader { geometry in
            let itemWidth = (geometry.size.width - 68) / 3
            VStack {
                headerView
                
                displayView

                ScrollView(.vertical) {
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(viewModel.pokemon, id: \.self.id) { pokemon in
                            PokemonGalleryItemView(isShiny: viewModel.isShiny, pokemon: pokemon)
                                .frame(width: itemWidth)
                                .onTapGesture {
                                    viewModel.selectedPokemon = pokemon
                                }
                                .onAppear {
                                    if pokemon == viewModel.pokemon.last {
                                        viewModel.loadMoreEntries()
                                    }
                                }
                        }

                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .background(Constants.Colors.pokemonRedFade)
        .onAppear {
            if viewModel.pokemon.isEmpty {
                viewModel.getPokedexEntries()
            }
        }
    }

    private var headerView: some View {
        HStack {
            Text("PokedexApp")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(Constants.Colors.pokemonBlue)

            Spacer()

            Toggle(isOn: $viewModel.isShiny) {
                Text("Shiny")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(Constants.Colors.yellow)
            }
            .frame(width: 100)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
        .background(Constants.Colors.pokemonDarkRed.opacity(0.5))
    }

    private var displayView: some View {
        VStack {
            if let selectedPokemon = viewModel.selectedPokemon {
                VStack(spacing: 8) {
                    Text(selectedPokemon.name.capitalized)
                        .font(.system(size: 24, weight: .bold))

                    HStack {
                        Spacer()

                        CachingImageView(url: viewModel.isShiny ? selectedPokemon.sprites.frontShiny : selectedPokemon.sprites.frontDefault)
                            .frame(width: 150, height: 150)

                        CachingImageView(url: viewModel.isShiny ? selectedPokemon.sprites.backShiny : selectedPokemon.sprites.backDefault)
                            .frame(width: 100, height: 100)

                        Spacer()
                    }

                    HStack {
                        ForEach(selectedPokemon.types, id: \.self.type.name) { type in
                            Image(type.type.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 30)
                        }
                    }

                    HStack(spacing: 24) {
                        Text("Height: \(String(format: "%.1f", selectedPokemon.height / 10.0))m")
                            .font(.system(size: 18, weight: .semibold))

                        Text("Weight: \(String(format: "%.1f", selectedPokemon.weight / 10.0))kg")
                            .font(.system(size: 18, weight: .semibold))
                    }

                    Text("Abilities: \(selectedPokemon.abilities.map { $0.ability.name }.joined(separator: ", "))")
                        .font(.system(size: 14))

                }
                .padding(8)
            } else {
                Text("Please Select a Pokemon")
                    .foregroundStyle(.white)
                    .padding(24)
            }
        }
        .background(Constants.Colors.pokemonBlue.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal, 24)
    }
}
