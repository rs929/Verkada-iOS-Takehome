//
//  Type.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation

struct TypeResponse: Codable {
    let sprites: Generation
}

struct Generation: Codable {
    let gen8: Gen8

    enum CodingKeys: String, CodingKey {
        case gen8 = "generation-viii"
    }
}

struct Gen8: Codable {
    let bdsp: TypeIconImage

    enum CodingKeys: String, CodingKey {
        case bdsp = "brilliant-diamond-and-shining-pearl"
    }
}

struct TypeIconImage: Codable {
    let name_icon: URL
}




