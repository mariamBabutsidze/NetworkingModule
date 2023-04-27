//
//  AnimalRow.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import SwiftUI

struct AnimalRow: View {
    let animal: Animal
    var animalName: String
    var animalType: String
    var animalDescription: String
    
    init(animal: Animal) {
        self.animal = animal
        animalName = animal.name
        animalType = animal.type
        animalDescription = animal.description
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: animal.picture) { image in
                image
                    .resizable()
                    .accessibilityLabel("Image of Pet")
            } placeholder: {
                Image("rw-logo")
                    .resizable()
                    .accessibilityLabel("Placeholder Logo")
                    .overlay {
                        if animal.picture != nil {
                            ProgressView()
                                .accessibilityLabel("Image loading indicator")
                                .accessibilityHidden(true)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.gray.opacity(0.4))
                        }
                    }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 112, height: 112)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(animalName)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("sheep_sans", size: 18, relativeTo: .title3))
                    .accessibilityLabel(animalName)
                Text(animalDescription)
                    .lineLimit(2)
                    .font(.footnote)
                    .accessibilityLabel(animalDescription)
                    .accessibilityHidden(true)
            }
        }
        .lineLimit(1)
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent("Type", animalType)
        .accessibilityCustomContent("Description", animalDescription)
    }
}
