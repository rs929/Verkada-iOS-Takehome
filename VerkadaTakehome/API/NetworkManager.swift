//
//  NetworkManager.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import Foundation
import os

class NetworkManager {

    // MARK: - Singleton Instance

    static let shared = NetworkManager()

    // MARK: - Error Logger for Networking

    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Network")

    // MARK: - Properties

    private let hostURL: String = Keys.serverURL

    // MARK: - Init

    private init() { }

    // MARK: - Template Helper Functions

    func get<T>(url: URL) async throws -> T where T : Decodable {
        let request = try createRequest(url: url, method: "GET")

        let (data, response) = try await URLSession.shared.data(for: request)

        try handleResponse(data: data, response: response)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(T.self, from: data)
    }

    private func createRequest(url: URL, method: String, body: Data? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = body
        return request
    }

    private func constructURL(endpoint: String) throws -> URL {
        guard let url = URL(string: "\(hostURL)\(endpoint)") else {
            logger.error("Failed to construct URL for endpoint: \(endpoint)")
            throw URLError(.badURL)
        }

        return url
    }

    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if httpResponse.statusCode != 200 {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
    }

    // MARK: - Pokedex Reqeusts

    func getPokedexEntries(limit: Int = 20, offset: Int = 0) async throws -> [Pokemon] {
        let url = try constructURL(endpoint: "pokemon?limit=\(limit)&offset=\(offset)")
        let response: PokedexResponse = try await get(url: url)

        return try await withThrowingTaskGroup(of: Pokemon.self) { group in
            for result in response.results {
                group.addTask {
                    try await self.getPokemonDetails(from: result.url)
                }
            }

            var entries: [Pokemon] = []
            for try await entry in group {
                entries.append(entry)
            }
            return entries.sorted { $0.id < $1.id }
        }
    }

    private func getPokemonDetails(from url: URL) async throws -> Pokemon {
        let details: Pokemon = try await get(url: url)

        return details
    }
}

