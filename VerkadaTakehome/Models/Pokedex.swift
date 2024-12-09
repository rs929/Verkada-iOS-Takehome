//
//  Pokedex.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation

struct PokedexResponse: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokedexEntry]
}

struct PokedexEntry: Codable {
    let name: String
    let url: URL
}

