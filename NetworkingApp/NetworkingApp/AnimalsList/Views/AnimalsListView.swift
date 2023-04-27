//
//  AnimalsListView.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import SwiftUI

struct AnimalsListView: View {
    @ObservedObject var viewModel: AnimalsListViewModel
    @State private var alertIsPresented = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.animals) { animal in
                    AnimalRow(animal: animal)
                }
            }
            .task {
                do {
                    try await viewModel.fetchAnimals()
                } catch {
                    alertIsPresented = true
                    alertMessage = error.localizedDescription
                }
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .alert("Error", isPresented: $alertIsPresented) {
                
            } message: {
                Text(alertMessage)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
