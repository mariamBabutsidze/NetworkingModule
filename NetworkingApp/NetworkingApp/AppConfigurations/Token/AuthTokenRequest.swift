//
//  AuthTokenRequest.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 27.04.23.
//

import Foundation
import Networking

enum AuthTokenRequest: RequestProtocol {
    case auth
    
    var host: String {
        APIConstants.host
    }
    
    var path: String {
        "/v2/oauth2/token"
    }
    
    var body: [String: Any] {
        [
            "grant_type": APIConstants.grantType,
            "client_id": APIConstants.clientId,
            "client_secret": APIConstants.clientSecret
        ]
    }
    
    var requestType: RequestType {
        .POST
    }
}
