//
//  ContentView.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 24.04.23.
//

import SwiftUI
import Networking

struct ContentView: View {
    var body: some View {
        TabView {
            AnimalsListView(
                viewModel: AnimalsListViewModel(
                    animalFetcher: FetchAnimalsService(
                        requestManager:
                            ApiManager()
                    )
                )
            )
            .tabItem {
                Label("Near you", systemImage: "location")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
