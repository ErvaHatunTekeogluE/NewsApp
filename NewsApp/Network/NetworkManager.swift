//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Erva Hatun Tekeoğlu on 26.09.2023.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
    case unknown
    case httpError(Int)
}

class NetworkManager {
    let apiKey = Config.apiKey
    
}
