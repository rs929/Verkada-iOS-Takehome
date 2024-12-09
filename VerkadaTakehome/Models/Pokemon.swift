//
//  Pokemon.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Double
    let isDefault: Bool
    let order: Int
    let weight: Double
    let abilities: [PokemonAbility]
    let gameIndices: [VersionGameIndex]
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    let types: [PokemonType]
}

struct NamedAPIResource: Codable, Equatable {
    let name: String
    let url: URL
}

struct PokemonAbility: Codable, Equatable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedAPIResource
}

struct VersionGameIndex: Codable, Equatable {
    let gameIndex: Int
    let version: NamedAPIResource
}

struct PokemonSprites: Codable, Equatable {
    let frontDefault: URL?
    let frontShiny: URL?
    let frontFemale: URL?
    let frontShinyFemale: URL?
    let backDefault: URL?
    let backShiny: URL?
    let backFemale: URL?
    let backShinyFemale: URL?
}

struct PokemonStat: Codable, Equatable {
    let stat: NamedAPIResource
    let effort: Int
    let baseStat: Int
}

struct PokemonType: Codable, Equatable {
    let slot: Int
    let type: NamedAPIResource
}



