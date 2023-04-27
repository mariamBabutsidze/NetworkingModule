//
//  AnimalsListViewModel.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation

protocol AnimalsFetcher {
    func fetchAnimals() async throws -> [Animal]
}

@MainActor
final class AnimalsListViewModel: ObservableObject {
    private let animalFetcher: AnimalsFetcher
    var animals: [Animal] = []
    
    init(animalFetcher: AnimalsFetcher) {
        self.animalFetcher = animalFetcher
    }
    
    func fetchAnimals() async throws {
        animals = try await animalFetcher.fetchAnimals()
    }
}
