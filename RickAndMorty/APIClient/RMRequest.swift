//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Mustafa Ali Dikcinar on 10.06.2023.
//

import Foundation

final class RMRequest {
    private enum Constants {
        static let baseURL = "https://rickandmortyapi.com/api/"
    }

    private let endpoint: RMEndpoint
    private let pathComponents: Set<String>
    private let queryParametters: [URLQueryItem]

    private var urlString: String {
        var string = Constants.baseURL
        string.append("/\(endpoint.rawValue)")
        if !pathComponents.isEmpty {
            string.append("/\(pathComponents.joined(separator: "/"))")
        }
        if !queryParametters.isEmpty {
            string.append("?\(queryParametters.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&"))")
        }
        return string
    }

    public var url: URL? {
        URL(string: urlString)
    }

    public init(
        endpoint: RMEndpoint,
        pathComponents: Set<String> = [],
        queryParametters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParametters = queryParametters
    }
}
