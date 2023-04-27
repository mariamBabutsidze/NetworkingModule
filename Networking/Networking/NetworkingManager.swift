//
//  NetworkingManager.swift
//  Networking
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation

public protocol NetworkingManagerProtocol {
    func load(_ request: RequestProtocol) async throws -> Data
    func load<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

public extension NetworkingManagerProtocol {
    
    func load<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await load(request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

public class NetworkingManager: NetworkingManagerProtocol {
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func load(_ request: RequestProtocol) async throws -> Data {
        print(request.host)
        print(request.headers)
        print(request.body)
        print(request.path)
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        print(response)
        print(data)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
