//
//  RequestProtocol.swift
//  Networking
//
//  Created by Mariam Babutsidze on 24.04.23.
//

import Foundation

protocol RequestProtocol {
    var host: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
    var query: [String: String]? { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if query?.isEmpty == false {
            components.queryItems = query?.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
