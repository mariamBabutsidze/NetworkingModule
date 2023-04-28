//
//  ApiManager.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 27.04.23.
//

import Foundation
import Networking

protocol ApiManagerProtocol {
    var networkManager: NetworkingManagerProtocol { get }
    func load<T: Decodable>(with data: RequestProtocol) async throws -> T
}

class ApiManager: ApiManagerProtocol {
    let networkManager: NetworkingManagerProtocol
    let accessTokenManager: AccessTokenManagerProtocol
    
    init(
        networkManager: NetworkingManagerProtocol = NetworkingManager(),
        accessToken: AccessTokenManagerProtocol = AccessTokenManager.shared
    ) {
        self.networkManager = networkManager
        self.accessTokenManager = accessToken
    }
    
    func requestAccessToken() async throws {
        if accessTokenManager.isTokenValid() {
            return
        }
        
        let token: APIToken = try await networkManager.load(AuthTokenRequest.auth)
        try accessTokenManager.refreshWith(apiToken: token)
    }
    
    func load<T: Decodable>(with data: RequestProtocol) async throws -> T {
        try await requestAccessToken()
        return try await networkManager.load(data)
    }
}
