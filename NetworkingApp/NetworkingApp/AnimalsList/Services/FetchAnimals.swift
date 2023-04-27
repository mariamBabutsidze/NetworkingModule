//
//  FetchAnimals.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation
import Networking

actor FetchAnimalsService {
    private let requestManager: ApiManagerProtocol
    
    init(requestManager: ApiManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchAnimalsService: AnimalsFetcher {
    func fetchAnimals() async throws -> [Animal] {
        let requestData = AnimalListRequest.getAnimals
        let animalsContainer: AnimalsContainer = try await requestManager.load(with: requestData)
        return animalsContainer.animals
    }
}
