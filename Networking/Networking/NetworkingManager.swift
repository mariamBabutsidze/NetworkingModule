//
//  NetworkingManager.swift
//  Networking
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation

protocol NetworkingManagerProtocol {
    func load(_ request: RequestProtocol) async throws -> Data
    func load<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

extension NetworkingManagerProtocol {
    func load<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await load(request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return try decoder.decode(T.self, from: data)
    }
}

class NetworkingManager: NetworkingManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func load(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        return data
    }

}
