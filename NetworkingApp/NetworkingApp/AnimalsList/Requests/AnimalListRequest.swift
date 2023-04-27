//
//  AnimalListRequest.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation
import Networking

enum AnimalListRequest: RequestProtocol {
    case getAnimals
    
    var host: String {
        APIConstants.host
    }
    
    var path: String {
        "/v2/animals"
    }

    var requestType: RequestType {
        .GET
    }
}
