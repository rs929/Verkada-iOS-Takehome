//
//  Keys.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation

struct Keys {

    static let serverURL = Keys.mainKeyDict(key: "SERVER_URL")

    private static func mainKeyDict(key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else { return "" }
        return dict[key] as? String ?? ""
    }
}

